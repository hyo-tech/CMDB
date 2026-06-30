#!/bin/bash
# ITOM Demo 环境一键部署脚本
# 用法: ./install.sh <demo_hostname> [--imageTag <tag>]
#   demo_hostname   (必填) 替换 .env 文件中的 <demo_hostname> 占位符
#   --imageTag <tag> 替换 docker-compose.yml 中 itom 和 keycloak 镜像的 tag

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="${SCRIPT_DIR}/.."
COMPOSE_FILE="${PROJECT_DIR}/docker-compose.yml"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

usage() {
    echo "用法: $0 <demo_hostname> [--imageTag <tag>]"
    echo "  demo_hostname   (必填) 替换 .env 文件中的 <demo_hostname> 占位符"
    echo "  --imageTag <tag> 替换 docker-compose.yml 中 itom 和 keycloak 的镜像 tag"
    exit 1
}

# 第一个必填参数: demo_hostname
[ $# -eq 0 ] && { log_error "缺少必填参数 demo_hostname e.g demo.xxxx.com"; usage; }
DEMO_HOSTNAME="$1"
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
        *)
            usage
            ;;
    esac
    shift
done

ENV_FILE="${PROJECT_DIR}/.env"
if grep -q '<demo_hostname>' "$ENV_FILE" 2>/dev/null; then
    log_info "替换 .env 中的 <demo_hostname> 为: ${DEMO_HOSTNAME}"
    sed -i "s/<demo_hostname>/${DEMO_HOSTNAME}/g" "$ENV_FILE"
    log_info ".env 替换完成"
else
    log_info ".env 中未发现 <demo_hostname> 占位符，跳过替换"
fi

# 检查并生成证书
CERT_DIR="${PROJECT_DIR}/conf/certificates"
if [ -f "${CERT_DIR}/dev.crt" ] && [ -f "${CERT_DIR}/dev.key" ]; then
    log_info "检测到已有证书，跳过生成"
else
    log_warn "未检测到 dev.crt 或 dev.key，开始生成证书..."
    bash "${SCRIPT_DIR}/generate-certs.sh"
    log_info "证书生成完成"
fi

# 替换镜像 tag（如果指定了 --imageTag）
if [ -n "$IMAGE_TAG" ]; then
    log_info "替换镜像 tag 为: $IMAGE_TAG"
    sed -i -E "s|(huayang/itom/itom):[^ ]+|\1:${IMAGE_TAG}|g" "$COMPOSE_FILE"
    sed -i -E "s|(huayang/itom/keycloak):[^ ]+|\1:${IMAGE_TAG}|g" "$COMPOSE_FILE"
    log_info "镜像 tag 替换完成"
fi

# 如果有旧环境在运行，先停止并清理
cd "$PROJECT_DIR"
if docker compose ps -q 2>/dev/null | grep -q .; then
    log_info "检测到运行中的环境，停止并清理..."
    docker compose down -v
else
    log_info "未检测到运行中的环境，继续执行"
fi

# 启动新环境
log_info "启动 demo 环境..."
docker compose up -d

# 等待服务启动
log_info "等待服务启动（约 30 秒）..."
sleep 30

log_info "=========================================="
log_info "Demo 环境已经就绪，请访问：https://${DEMO_HOSTNAME}:4443/ui/100000001"
log_info "=========================================="
