#!/bin/bash
# lib/messages.sh — 中→英 词表（被 lib/i18n.sh 在 bash 4+ 下 source）
#
# 约定:
#   - key = 脚本里出现的「中文字面串」（_t 调用）或「中文 printf 格式串」（tf 调用，占位符用 %s/%d）。
#   - zh 模式不需要任何条目（原样输出中文）；这里只写 en 翻译。
#   - 未命中的 key 自动回退中文，不会报错。新增串时：把「中文原串」原样作为 key，value 写英文。
#
# 命名空间：所有脚本共用同一张 MSG_EN 表（按中文字面去重，跨脚本相同的串只写一次）。

# ===== install-community-docker-compose.sh =====
MSG_EN["缺少必填参数 host_FQDN e.g community.xxxx.com"]="Missing required argument host_FQDN e.g. community.xxxx.com"
MSG_EN["--imageTag 需要指定一个 tag 值"]="--imageTag requires a tag value"
MSG_EN[".env 替换完成"]=".env replacement done"
MSG_EN[".env 中未发现 <host_FQDN> 占位符，跳过替换"]="<host_FQDN> placeholder not found in .env, skipping replacement"
MSG_EN["检测到已有证书，跳过生成"]="Existing certificates detected, skipping generation"
MSG_EN["未检测到 dev.crt 或 dev.key，开始生成证书..."]="dev.crt or dev.key not found, generating certificates..."
MSG_EN["证书生成完成"]="Certificate generation complete"
MSG_EN["镜像 tag 替换完成"]="Image tag replacement complete"
MSG_EN["旧环境清理完成"]="Old environment cleanup complete"
MSG_EN["在线模式：拉取镜像（公开仓库，无需认证）..."]="Online mode: pulling images (public registry, no auth needed)..."
MSG_EN["启动社区版环境..."]="Starting community environment..."
MSG_EN["等待应用就绪..."]="Waiting for application to be ready..."
MSG_EN["应用已就绪"]="Application is ready"
MSG_EN["应用仍在初始化中，请稍候 1-2 分钟再访问"]="Application is still initializing; please try accessing it in 1-2 minutes"
MSG_EN["社区版环境已经就绪，请访问：%s"]="Community environment is ready, please visit: %s"
MSG_EN["替换 .env 中的 <host_FQDN> 为: %s"]="Replacing <host_FQDN> in .env with: %s"
MSG_EN["替换镜像 tag 为: %s"]="Replacing image tag with: %s"
MSG_EN["清理项目 %s 下的所有容器、网络与卷..."]="Cleaning all containers, networks and volumes under project %s..."
MSG_EN["发现项目 %s 的残留容器，强制移除..."]="Found residual containers of project %s, force removing..."

# ===== generate-certs.sh =====
MSG_EN["证书已成功生成:"]="Certificates generated successfully:"
MSG_EN["- 证书文件: %s"]="- Certificate file: %s"
MSG_EN["- 密钥文件: %s"]="- Key file: %s"
MSG_EN["- 有效期: 365天"]="- Validity: 365 days"
MSG_EN["- 包含主机名: %s"]="- Includes hostname: %s"
MSG_EN["- 包含IP地址: %s"]="- Includes IP address: %s"

# ===== generate-passwords.sh =====
MSG_EN["ITOM-Chart Password Generation Script"]="ITOM-Chart Password Generation Script"
MSG_EN["Keycloak 系统租户 sysadmin"]="Keycloak system-tenant sysadmin"
MSG_EN["Keycloak 默认租户(100000001) admin"]="Keycloak default-tenant (100000001) admin"
MSG_EN["外部数据库"]="External database"
MSG_EN["输入%s密码: "]="Enter %s password: "
MSG_EN["确认%s密码（再输入一次）: "]="Confirm %s password (enter again): "
MSG_EN["已设置%s密码"]="%s password set"
MSG_EN["密码不符合策略: %s，请重新输入（至少 8 位，含大写/小写/数字/特殊字符）"]="Password does not meet policy: %s, please re-enter (at least 8 chars with uppercase/lowercase/digit/special char)"
MSG_EN["%s密码不能为空，请重新输入"]="%s password cannot be empty, please re-enter"
MSG_EN["关键密码设置完成，其他内部服务密钥将自动生成"]="Key passwords set; other internal service secrets will be auto-generated"
MSG_EN["需要您亲自设置以下密码（不能为空，需输入两次确认一致）："]="Please set the following passwords (non-empty, confirmed twice):"
MSG_EN["Keycloak 系统租户 sysadmin 密码（租户 100000000）"]="Keycloak system-tenant sysadmin password (tenant 100000000)"
MSG_EN["Keycloak 默认租户 admin 密码（租户 100000001）"]="Keycloak default-tenant admin password (tenant 100000001)"
MSG_EN["外部数据库密码（须与 DBA 创建用户时设定的真实密码一致）"]="External database password (must match the real password set by DBA)"
MSG_EN["其他内部服务密钥将自动生成"]="Other internal service secrets will be auto-generated"
MSG_EN["Keycloak 密码策略: 至少 8 位，含大写字母、小写字母、数字、特殊字符"]="Keycloak password policy: at least 8 chars with uppercase, lowercase, digit, special char"
MSG_EN["交互式密码输入模式"]="Interactive password input mode"
MSG_EN["使用参数传递的 Keycloak 管理员密码"]="Using Keycloak admin password from parameter"
MSG_EN["使用参数传递的 Keycloak sysadmin 密码"]="Using Keycloak sysadmin password from parameter"
MSG_EN["使用参数传递的 Keycloak 默认租户 admin 密码"]="Using Keycloak default-tenant admin password from parameter"
MSG_EN["使用参数传递的外部数据库密码"]="Using external database password from parameter"
MSG_EN["生成密码..."]="Generating passwords..."
MSG_EN["GitLab CI 模式：使用默认测试密码"]="GitLab CI mode: using default test passwords"
MSG_EN["所有密码已生成"]="All passwords generated"
MSG_EN["密码生成完成！"]="Password generation complete!"

# ===== install-production.sh — 步骤 7 密码生成 =====
MSG_EN["步骤 7/10: 生成服务密码并创建 Secret"]="Step 7/10: Generate service passwords and create Secret"
MSG_EN["生成密码并直接 apply Secret 到集群（不落盘）..."]="Generating passwords and applying Secret directly to cluster (no disk write)..."
MSG_EN["Secret %s 已创建（仅存于集群，不落盘）"]="Secret %s created (cluster only, never written to disk)"
