#!/bin/bash
# ITOM 社区版环境一键部署脚本（在线模式）
# 用法: ./install.sh <host_FQDN> [--imageTag <tag>]
#   host_FQDN   (必填) 替换 .env 文件中的 <host_FQDN> 占位符
#   --imageTag <tag>     替换 docker-compose.yml 中 itom、keycloak、forwardauth、device-executor 镜像的 tag
#
# 社区版为纯在线部署：镜像从公开镜像仓库拉取（无需认证），不存在离线加载分支。

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 中英文双语：source i18n（按 locale 自动检测）+ 预扫 --lang 显式覆盖
# shellcheck source=lib/i18n.sh
source "${SCRIPT_DIR}/lib/i18n.sh"
i18n_prescan_lang "$@"
PROJECT_DIR="${SCRIPT_DIR}/.."
COMPOSE_FILE="${PROJECT_DIR}/docker-compose.yml"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info()  { echo -e "${GREEN}[INFO]${NC} $(_t "$1")"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $(_t "$1")"; }
log_error() { echo -e "${RED}[ERROR]${NC} $(_t "$1")"; }

usage() {
    case "$ITOM_LANG" in
        en)
            echo "Usage: $0 <host_FQDN> [--imageTag <tag>]"
            echo "  host_FQDN   (required) Replaces the <host_FQDN> placeholder in the .env file"
            echo "  --imageTag <tag>     Replaces the image tag of itom, keycloak, forwardauth, device-executor in docker-compose.yml"
            ;;
        zh|*)
            echo "用法: $0 <host_FQDN> [--imageTag <tag>]"
            echo "  host_FQDN   (必填) 替换 .env 文件中的 <host_FQDN> 占位符"
            echo "  --imageTag <tag>     替换 docker-compose.yml 中 itom、keycloak、forwardauth、device-executor 的镜像 tag"
            ;;
    esac
    exit 1
}

# 第一个必填参数: host_FQDN
[ $# -eq 0 ] && { log_error "缺少必填参数 host_FQDN e.g community.xxxx.com"; usage; }
HOST_FQDN="$1"
shift

# 参数解析
IMAGE_TAG=""

while [ $# -gt 0 ]; do
    case "$1" in
        --imageTag)
            [ -z "${2:-}" ] && { log_error "--imageTag 需要指定一个 tag 值"; usage; }
            IMAGE_TAG="$2"
            shift
            ;;
        --lang) [ $# -ge 2 ] && shift ;;   # 值已由 i18n_prescan_lang 处理；此处仅跳过 token
        *)
            usage
            ;;
    esac
    shift
done

ENV_FILE="${PROJECT_DIR}/.env"
if grep -q '<host_FQDN>' "$ENV_FILE" 2>/dev/null; then
    log_info "$(tf "替换 .env 中的 <host_FQDN> 为: %s" "$HOST_FQDN")"
    sed -i "s/<host_FQDN>/${HOST_FQDN}/g" "$ENV_FILE"
    log_info ".env 替换完成"
else
    log_info ".env 中未发现 <host_FQDN> 占位符，跳过替换"
fi

# 0. 检查并生成证书
CERT_DIR="${PROJECT_DIR}/conf/certificates"
if [ -f "${CERT_DIR}/dev.crt" ] && [ -f "${CERT_DIR}/dev.key" ]; then
    log_info "检测到已有证书，跳过生成"
else
    log_warn "未检测到 dev.crt 或 dev.key，开始生成证书..."
    bash "${SCRIPT_DIR}/generate-certs.sh"
    log_info "证书生成完成"
fi

# 0.1 AI 模型配置检查（.env 文件）
AI_MODEL_API_KEY="$(grep -E '^ITOM_MODEL_API_KEY=' "$ENV_FILE" 2>/dev/null | cut -d= -f2- | tr -d '[:space:]')"
if [ -n "$AI_MODEL_API_KEY" ]; then
    log_info "AI 模型配置: API Key 已设置（AI 功能可用）"
else
    log_warn "AI 模型配置缺失：.env 文件中 ITOM_MODEL_API_KEY 未设置"
    log_warn "AI 相关功能（AI 助手 / AI 驱动的运维）将不可用，直到补齐模型配置"
    log_warn "$(tf "补齐方式：编辑 %s 填 ITOM_MODEL_{NAME,BASE_URL,API_KEY}" "$ENV_FILE")"
    read -p "$(_t "  不启用 AI 继续安装? [y/N]: ")" ai_continue
    [[ "${ai_continue}" =~ ^[Yy]$ ]] || { log_info "安装已取消"; exit 0; }
fi

# 1. 替换镜像 tag（如果指定了 --imageTag）
if [ -n "$IMAGE_TAG" ]; then
    log_info "$(tf "替换镜像 tag 为: %s" "$IMAGE_TAG")"
    sed -i -E "s|(hyo-tech/itom/itom):[^ ]+|\1:${IMAGE_TAG}|g" "$COMPOSE_FILE"
    sed -i -E "s|(hyo-tech/itom/keycloak):[^ ]+|\1:${IMAGE_TAG}|g" "$COMPOSE_FILE"
    sed -i -E "s|(hyo-tech/itom/forwardauth):[^ ]+|\1:${IMAGE_TAG}|g" "$COMPOSE_FILE"
    sed -i -E "s|(hyo-tech/itom/device-executor):[^ ]+|\1:${IMAGE_TAG}|g" "$COMPOSE_FILE"
    log_info "镜像 tag 替换完成"
fi

# 2. 彻底清理旧环境（含其它版本 compose 遗留的 orphan 服务）后再部署
#    说明：docker compose down 只能移除“当前 compose 文件中定义的服务”，无法清理
#    其它版本（如 1.0.0）遗留下来的 orphan 容器。这些 orphan 与新版服务共存会导致
#    traefik 中间件/路由冲突 —— 例如旧版 oauth2-proxy 与新版 forwardauth 同时声明
#    同名中间件 oauth2-proxy → traefik 丢弃该中间件 → 依赖它的路由（如 /ui）被禁用 → 404。
#    因此这里按 project 标签强制清理本项目下的所有容器/网络/卷，确保干净部署。
cd "$PROJECT_DIR"
PROJECT_NAME="$(grep -E '^COMPOSE_PROJECT_NAME=' .env 2>/dev/null | cut -d= -f2- | tr -d '[:space:]')"
PROJECT_NAME="${PROJECT_NAME:-cmdb}"
log_info "$(tf "清理项目 %s 下的所有容器、网络与卷..." "$PROJECT_NAME")"
docker compose down -v --remove-orphans 2>/dev/null || true
# 兜底：强制移除任何带本项目标签的残留容器（跨版本 orphan 或 down 未覆盖的情况）
RESIDUAL="$(docker ps -aq --filter "label=com.docker.compose.project=${PROJECT_NAME}")"
if [ -n "$RESIDUAL" ]; then
    log_warn "$(tf "发现项目 %s 的残留容器，强制移除..." "$PROJECT_NAME")"
    echo "$RESIDUAL" | xargs -r docker rm -f >/dev/null 2>&1 || true
fi
# 清理本项目残留的 compose 网络
docker network ls --filter "label=com.docker.compose.project=${PROJECT_NAME}" -q 2>/dev/null \
    | xargs -r docker network rm >/dev/null 2>&1 || true
log_info "旧环境清理完成"

# 3. 拉取镜像（公开仓库，无需认证）并启动
log_info "在线模式：拉取镜像（公开仓库，无需认证）..."
docker compose pull
log_info "启动社区版环境..."
mkdir -p logs
# 容器以非 root 用户 appuser 运行，会往 /cmdb/logs 写日志；而 install 通常以 sudo 运行
# （443 端口绑定需要 root），创建的目录归 root → appuser 无写权限 → log4js 报 EACCES
# 导致服务启动崩溃。预建各服务日志子目录并放开写权限（社区/demo 环境），docker up 时
# 直接复用这些目录。服务列表需与 docker-compose.yml 中 ./logs/<svc>:/cmdb/logs 挂载保持一致。
mkdir -p logs/cmdb logs/api logs/ai-agent logs/monitoring logs/cmdb-ui logs/proxy logs/traefik
chmod 0777 logs logs/cmdb logs/api logs/ai-agent logs/monitoring logs/cmdb-ui logs/proxy logs/traefik 2>/dev/null || true
docker compose up -d

# 4. 主动等待 Keycloak realm 就绪（替代固定 sleep：realm 未就绪时登录会 404）
CONTEXT_PATH_VAL="$(grep -E '^CONTEXT_PATH=' "$ENV_FILE" 2>/dev/null | cut -d= -f2- | tr -d '[:space:]')"
WEBSECURE_PORT_VAL="$(grep -E '^WEBSECURE_PORT=' "$ENV_FILE" 2>/dev/null | cut -d= -f2- | tr -d '[:space:]')"
WEBSECURE_PORT_VAL="${WEBSECURE_PORT_VAL:-443}"
REALM_URL="https://localhost:${WEBSECURE_PORT_VAL}${CONTEXT_PATH_VAL}/idm/realms/100000001/.well-known/openid-configuration"
log_info "等待应用就绪..."
REALM_READY=0
for _i in $(seq 1 60); do
  if [ "$(curl -sk -o /dev/null -w '%{http_code}' "$REALM_URL" 2>/dev/null || echo 000)" = "200" ]; then
    REALM_READY=1; break
  fi
  sleep 5
done
if [ "$REALM_READY" = "1" ]; then
  log_info "应用已就绪"
else
  log_warn "应用仍在初始化中，请稍候 1-2 分钟再访问"
fi

if [ "$WEBSECURE_PORT_VAL" = "443" ] || [ "$WEBSECURE_PORT_VAL" = "80" ]; then
  ACCESS_URL="https://${HOST_FQDN}${CONTEXT_PATH_VAL}/ui/100000001"
else
  ACCESS_URL="https://${HOST_FQDN}:${WEBSECURE_PORT_VAL}${CONTEXT_PATH_VAL}/ui/100000001"
fi

log_info "=========================================="
log_info "$(tf "社区版环境已经就绪，请访问：%s" "$ACCESS_URL")"
log_info "=========================================="
