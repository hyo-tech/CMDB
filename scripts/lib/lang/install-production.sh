#!/bin/bash
# lib/lang/install-production.sh — install-production.sh 词表片段
# 被 lib/i18n.sh 在 bash 4+ 下 source

# ===== 参数校验 =====
MSG_EN["缺少必填参数: -n/--namespace"]="Missing required argument: -n/--namespace"
MSG_EN["缺少必填参数: -f/--values（客户填好的 values 文件）"]="Missing required argument: -f/--values (customer-filled values file)"
MSG_EN["缺少必填参数: --storage-values（存储 overlay 文件）"]="Missing required argument: --storage-values (storage overlay file)"
MSG_EN["命名空间格式无效: '%s'。只允许小写字母、数字和连字符"]="Invalid namespace format: '%s'. Only lowercase letters, numbers and hyphens are allowed"
MSG_EN["values 文件不存在: %s"]="Values file not found: %s"
MSG_EN["存储 overlay 文件不存在: %s"]="Storage overlay file not found: %s"

# ===== values 校验 =====
MSG_EN["values 中 %s 未填写（残留 TODO）：'%s'，请编辑 %s"]="%s in values is not filled (TODO remains): '%s', please edit %s"
MSG_EN["values 中 global.itomImage.registry 为空"]="global.itomImage.registry is empty in values"
MSG_EN["values 中 global.registryAuth.username 为空"]="global.registryAuth.username is empty in values"
MSG_EN["values 中 tls.mode 无效: '%s'（应为 selfSigned 或 userCA）"]="Invalid tls.mode in values: '%s' (should be selfSigned or userCA)"

# ===== 镜像包 / Chart =====
MSG_EN["镜像目录不存在: %s"]="Image directory not found: %s"
MSG_EN["自动找到镜像包:"]="Auto-detected image packages:"
MSG_EN["第三方镜像: %s"]="Third-party images: %s"
MSG_EN["产品镜像: %s"]="Product images: %s"
MSG_EN["找到 Chart 包: %s"]="Found Chart package: %s"
MSG_EN["解压后的 Chart 目录结构不符合预期"]="Extracted Chart directory structure is not as expected"
MSG_EN["未找到 Chart"]="Chart not found"
MSG_EN["在线模式：从 values 读取 Image Tag: %s"]="Online mode: reading Image Tag from values: %s"
MSG_EN["从镜像包提取到 Image Tag: %s（将覆盖 values 中的 tag）"]="Extracted Image Tag from image package: %s (will override tag in values)"
MSG_EN["未能从镜像包解析出 itom/itom tag，沿用 values 中的 tag"]="Failed to parse itom/itom tag from image package, using tag from values"

# ===== Registry 配置 =====
MSG_EN["在线模式：镜像仓库公开可拉取（registryAuth.enabled=false，无离线包），跳过 Registry 凭证与 imagePullSecret"]="Online mode: registry is publicly accessible (registryAuth.enabled=false, no offline package), skipping Registry credentials and imagePullSecret"
MSG_EN["使用 Registry: %s（用户: %s）"]="Using Registry: %s (user: %s)"
MSG_EN["CI 模式下 registryAuth.enabled=true 需通过 --registry-password / --registry-password-stdin 提供密码"]="In CI mode, registryAuth.enabled=true requires password via --registry-password or --registry-password-stdin"
MSG_EN["====== 镜像仓库密码 ======"]="====== Registry Password ======"
MSG_EN["  输入 %s 的密码: "]="  Enter password for %s: "
MSG_EN["registry 密码不能为空，请重新输入"]="Registry password cannot be empty, please try again"
MSG_EN["  确认 %s 的密码（再输入一次）: "]="  Confirm password for %s (enter again): "
MSG_EN["两次输入不一致，请重新输入"]="Passwords do not match, please try again"
MSG_EN["输入被中断"]="Input interrupted"
MSG_EN["未配置 registry 凭证：检测到离线镜像包但 registryAuth.enabled 非 true。请在 values 启用 registryAuth 并经 --registry-password / --registry-password-stdin 提供密码。"]="Registry credentials not configured: offline image package detected but registryAuth.enabled is not true. Please enable registryAuth in values and provide password via --registry-password or --registry-password-stdin."
MSG_EN["====== 镜像仓库配置 ======"]="====== Registry Configuration ======"
MSG_EN["检测到离线镜像包但 values 未启用 registryAuth。请提供 registry 凭证。"]="Offline image package detected but registryAuth is not enabled in values. Please provide registry credentials."
MSG_EN["  Registry 地址 [%s]: "]="  Registry address [%s]: "
MSG_EN["  用户名: "]="  Username: "
MSG_EN["  密码: "]="  Password: "
MSG_EN["Registry 地址和凭证不能为空"]="Registry address and credentials cannot be empty"
MSG_EN["验证 Registry 连通性..."]="Verifying Registry connectivity..."
MSG_EN["Registry 连通性验证通过"]="Registry connectivity verified"
MSG_EN["Registry 连通性验证失败，请确认地址和凭证是否正确"]="Registry connectivity verification failed, please check the address and credentials"
MSG_EN["  继续安装? [y/N]: "]="  Continue installation? [y/N]: "
MSG_EN["CI 模式下 Registry 连通性失败，中止部署"]="Registry connectivity failed in CI mode, aborting deployment"
MSG_EN["Registry imagePullSecret 已创建: %s"]="Registry imagePullSecret created: %s"
MSG_EN["创建 imagePullSecret 失败"]="Failed to create imagePullSecret"
MSG_EN["未创建 imagePullSecret（公开仓库/在线模式，镜像公开可拉取）"]="imagePullSecret not created (public registry/online mode, images publicly accessible)"

# ===== TLS / 证书 =====
MSG_EN["TLS 模式: selfSigned（cert-manager 自签 Issuer 自动签发）"]="TLS mode: selfSigned (cert-manager auto-signed Issuer)"
MSG_EN["TLS 模式: userCA（导入自备 CA 到 cert-manager）"]="TLS mode: userCA (import custom CA to cert-manager)"
MSG_EN["userCA 模式需在 values 填写 tls.userCA.caCertPath 与 caKeyPath"]="userCA mode requires tls.userCA.caCertPath and caKeyPath in values"
MSG_EN["userCA 模式下 tls.userCA.caCertPath/caKeyPath 未填写（残留 TODO）"]="tls.userCA.caCertPath/caKeyPath not filled in userCA mode (TODO remains)"
MSG_EN["CA 证书文件不存在: %s"]="CA certificate file not found: %s"
MSG_EN["CA 私钥文件不存在: %s"]="CA key file not found: %s"
MSG_EN["CA 证书不是有效的 PEM: %s"]="CA certificate is not valid PEM: %s"
MSG_EN["自备 CA 证书校验通过: %s"]="Custom CA certificate validated: %s"
MSG_EN["数据库 CA 证书缺失或文件不存在: %s（ssl.mode=%s 必须提供 CA 证书；如不校验，可改 ssl.mode=disable/prefer/require 或设 ssl.enabled=false）"]="Database CA certificate missing or file not found: %s (ssl.mode=%s requires a CA certificate; to skip verification set ssl.mode=disable/prefer/require or ssl.enabled=false)"
MSG_EN["数据库 CA 证书就绪: %s（ssl.mode=%s）"]="Database CA certificate ready: %s (ssl.mode=%s)"
MSG_EN["ssl.enabled=true 且 caCertSecret=%s 非空，但未提供有效 CA 证书（%s）—— chart 会挂载该 Secret，缺失将导致 Pod 起不来；请补齐 CA 文件或清空 caCertSecret"]="ssl.enabled=true and caCertSecret=%s is set, but no valid CA certificate provided (%s) — the chart will mount this Secret, missing it will prevent Pods from starting; provide a CA file or clear caCertSecret"
MSG_EN["数据库 CA 证书就绪: %s（ssl.mode=%s，PG 不强校验，但 chart 将挂载 Secret 备用）"]="Database CA certificate ready: %s (ssl.mode=%s; PG does not strictly verify, but the chart will mount the Secret for use)"
MSG_EN["数据库 SSL: enabled=%s, mode=%s —— 无需 CA 证书（仅 verify-ca/verify-full 才需要）"]="Database SSL: enabled=%s, mode=%s — no CA certificate needed (only verify-ca/verify-full require one)"
MSG_EN["数据库 CA 证书 Secret 创建成功"]="Database CA certificate Secret created successfully"
MSG_EN["数据库 CA 证书 Secret 已存在，使用现有证书"]="Database CA certificate Secret already exists, using existing certificate"
MSG_EN["创建数据库 CA 证书 Secret..."]="Creating database CA certificate Secret..."
MSG_EN["导入自备 CA 到 cert-manager..."]="Importing custom CA to cert-manager..."
MSG_EN["CA 证书 Secret 已创建: cert-manager/itom-ca-key-pair"]="CA certificate Secret created: cert-manager/itom-ca-key-pair"
MSG_EN["CA 证书 Secret 已存在: cert-manager/itom-ca-key-pair"]="CA certificate Secret already exists: cert-manager/itom-ca-key-pair"
MSG_EN["CA ClusterIssuer 已创建: itom-ca-issuer"]="CA ClusterIssuer created: itom-ca-issuer"
MSG_EN["CA ClusterIssuer 已存在: itom-ca-issuer"]="CA ClusterIssuer already exists: itom-ca-issuer"

# ===== 镜像加载 =====
MSG_EN["处理: %s"]="Processing: %s"
MSG_EN["处理: %s (使用skopeo直接推送 - 优化模式)"]="Processing: %s (using skopeo direct push - optimized mode)"
MSG_EN["处理: %s (使用ctr传统方法)"]="Processing: %s (using ctr traditional method)"
MSG_EN["解压镜像包到临时目录..."]="Extracting image package to temporary directory..."
MSG_EN["镜像包解压失败，请检查tar包是否损坏"]="Failed to extract image package, please check if the tar file is corrupted"
MSG_EN["解压完成，共 %s 个镜像文件"]="Extraction complete, %s image files in total"
MSG_EN["读取镜像映射文件 (%s 个镜像)..."]="Reading image mapping file (%s images)..."
MSG_EN["镜像文件不存在，跳过: %s"]="Image file not found, skipping: %s"
MSG_EN["  导入 [%s/%s]: %s"]="  Importing [%s/%s]: %s"
MSG_EN["  导入失败: %s"]="  Import failed: %s"
MSG_EN["  错误详情: %s"]="  Error details: %s"
MSG_EN["%s: 成功 %s 个, 失败 %s 个, 跳过 %s 个"]="%s: %s succeeded, %s failed, %s skipped"
MSG_EN["%s: 成功 %s 个, 失败 %s 个"]="%s: %s succeeded, %s failed"
MSG_EN["跳过的镜像文件:"]="Skipped image files:"
MSG_EN["镜像包可能不完整或损坏，请检查tar包文件"]="Image package may be incomplete or corrupted, please check the tar file"
MSG_EN["未找到镜像映射文件: %s"]="Image mapping file not found: %s"

# ===== 镜像推送 =====
MSG_EN["推送镜像到 Registry %s..."]="Pushing images to Registry %s..."
MSG_EN["  推送 [%s/%s]: %s"]="  Pushing [%s/%s]: %s"
MSG_EN["  推送失败: %s"]="  Push failed: %s"
MSG_EN["推送完成: 成功 %s, 失败 %s"]="Push complete: %s succeeded, %s failed"
MSG_EN["    推送成功"]="    Push succeeded"
MSG_EN["     错误: skopeo推送失败"]="     Error: skopeo push failed"
MSG_EN["检测到skopeo工具，使用优化推送方法 (跳过containerd导入)"]="skopeo detected, using optimized push method (skipping containerd import)"
MSG_EN["skopeo推送失败，回退到传统ctr方法"]="skopeo push failed, falling back to traditional ctr method"
MSG_EN["skopeo推送完成: 成功 %s/%s"]="skopeo push complete: %s/%s succeeded"
MSG_EN["skopeo推送部分失败: 成功 %s, 失败 %s"]="skopeo push partially failed: %s succeeded, %s failed"
MSG_EN["skopeo未安装，使用传统ctr方法"]="skopeo not installed, using traditional ctr method"
MSG_EN["镜像推送完成 (skopeo优化方法)"]="Image push complete (skopeo optimized method)"
MSG_EN["直接推送 %s 个镜像到私仓 (跳过containerd导入)..."]="Directly pushing %s images to private registry (skipping containerd import)..."

# ===== Registry GC =====
MSG_EN["清理 Registry 无引用 blobs（GC）..."]="Cleaning unreferenced blobs from Registry (GC)..."
MSG_EN["Registry GC 执行失败（不影响安装）"]="Registry GC failed (installation not affected)"
MSG_EN["Registry GC 完成，释放约 %s MB 无引用 blobs"]="Registry GC complete, freed ~%s MB unreferenced blobs"
MSG_EN["Registry GC 完成，无需清理"]="Registry GC complete, nothing to clean"

# ===== 磁盘空间 =====
MSG_EN["磁盘空间检查通过: 可用 %s GB (使用率 %s%%)"]="Disk space check passed: %s GB available (%s%% usage)"
MSG_EN["根分区可用空间仅 %s GB（建议 ≥ %s GB）"]="Root partition only has %s GB available (recommended ≥ %s GB)"
MSG_EN["镜像导入/推送可能因磁盘不足失败，建议清理后重试"]="Image import/push may fail due to insufficient disk space, please clean up and retry"
MSG_EN["磁盘空间不足: 需要 %sMB，/tmp 可用 %sMB"]="Insufficient disk space: %sMB required, %sMB available in /tmp"

# ===== AI 模型配置 =====
MSG_EN["AI 模型配置: API Key 已设置（AI 功能可用）"]="AI model config: API key is set (AI features available)"
MSG_EN["AI 模型配置缺失：services.aiAgent.env.ITOM_MODEL_API_KEY 未设置"]="AI model config missing: services.aiAgent.env.ITOM_MODEL_API_KEY is not set"
MSG_EN["AI 相关功能（AI 助手 / AI 驱动的运维）将不可用，直到补齐模型配置"]="AI-related features (AI assistant / AI-driven operations) will be unavailable until the model config is provided"
MSG_EN["补齐方式：编辑 %s 填 services.aiAgent.env.ITOM_MODEL_{NAME,BASE_URL,API_KEY}，或安装时加 --itom-model-name / --itom-model-base-url / --itom-model-api-key"]="To fix: edit %s and fill services.aiAgent.env.ITOM_MODEL_{NAME,BASE_URL,API_KEY}, or pass --itom-model-name / --itom-model-base-url / --itom-model-api-key at install time"
MSG_EN["  不启用 AI 继续安装? [y/N]: "]="  Continue without AI? [y/N]: "

# ===== 安装确认 =====
MSG_EN["安装配置确认"]="Installation Configuration Confirmation"
MSG_EN["命名空间:      %s"]="Namespace:      %s"
MSG_EN["Release:       %s"]="Release:       %s"
MSG_EN["Values:        %s"]="Values:        %s"
MSG_EN["存储配置:      %s"]="Storage:       %s"
MSG_EN["镜像 Tag:      %s（来自镜像包，覆盖 values）"]="Image Tag:      %s (from image package, overrides values)"
MSG_EN["AI Key:        已设置（覆盖 values）"]="AI Key:        Set (overrides values)"
MSG_EN["AI Key:        未设置（AI 功能不可用）"]="AI Key:        Not set (AI features unavailable)"
MSG_EN["访问域名:      %s"]="Access Domain: %s"
MSG_EN["TLS 模式:      %s"]="TLS Mode:      %s"
MSG_EN["镜像仓库:      %s"]="Registry:      %s"
MSG_EN["K8s Master:    %s"]="K8s Master:    %s"
MSG_EN["模式:          预览 (dry-run)"]="Mode:          Preview (dry-run)"
MSG_EN["即将开始安装，请确认以上配置是否正确。"]="Installation will begin. Please confirm the configuration above."
MSG_EN["  确认安装? [y/N]: "]="  Confirm installation? [y/N]: "
MSG_EN["安装已取消"]="Installation cancelled"

# ===== 欢迎信息 =====
MSG_EN["ITOM-Chart Production 一键安装脚本（模板驱动）"]="ITOM-Chart Production One-Click Installer (Template-Driven)"
MSG_EN["命名空间: %s"]="Namespace: %s"
MSG_EN["Values: %s"]="Values: %s"
MSG_EN["存储 overlay: %s"]="Storage overlay: %s"
MSG_EN["Release 名称: %s"]="Release name: %s"
MSG_EN["Chart 路径: %s"]="Chart path: %s"
MSG_EN["模式: 预览 (dry-run)"]="Mode: Preview (dry-run)"

# ===== 安装步骤 =====
MSG_EN["步骤 1/10: 校验 TLS 与证书配置"]="Step 1/10: Validating TLS and certificate configuration"
MSG_EN["步骤 2/10: 检查前置条件"]="Step 2/10: Checking prerequisites"
MSG_EN["步骤 3/10: 去除 master 节点 taint"]="Step 3/10: Removing taints from master node"
MSG_EN["步骤 4/10: 配置镜像仓库并加载离线镜像"]="Step 4/10: Configuring registry and loading offline images"
MSG_EN["步骤 5/10: 创建命名空间"]="Step 5/10: Creating namespace"
MSG_EN["步骤 6/10: 安装依赖组件"]="Step 6/10: Installing dependencies"
MSG_EN["步骤 6/10: 跳过依赖安装"]="Step 6/10: Skipping dependency installation"
MSG_EN["步骤 7/10: 生成服务密码并创建 Secret"]="Step 7/10: Generating service passwords and creating Secret"
MSG_EN["步骤 8/10: 创建证书相关 Secret"]="Step 8/10: Creating certificate-related Secrets"
MSG_EN["步骤 9/10: 安装 ITOM-Chart"]="Step 9/10: Installing ITOM-Chart"
MSG_EN["步骤 10/10: 验证安装"]="Step 10/10: Verifying installation"

# ===== Master 节点 taint =====
MSG_EN["检测到 master 节点: %s"]="Detected master node: %s"
MSG_EN["已去除 taint: %s"]="Removed taint: %s"
MSG_EN["未检测到 master 节点"]="No master node detected"

# ===== 镜像加载步骤 =====
MSG_EN["跳过镜像加载（--skip-images）"]="Skipping image loading (--skip-images)"
MSG_EN["K8s 节点: %s"]="K8s nodes: %s"
MSG_EN["未找到任何镜像包"]="No image packages found"
MSG_EN["镜像加载完成"]="Image loading complete"
MSG_EN["未找到镜像包，跳过镜像加载"]="No image packages found, skipping image loading"

# ===== 命名空间 =====
MSG_EN["命名空间 %s 已存在"]="Namespace %s already exists"
MSG_EN["命名空间 %s 已创建"]="Namespace %s created"

# ===== cert-manager / Ingress =====
MSG_EN["安装 cert-manager..."]="Installing cert-manager..."
MSG_EN["cert-manager 已安装"]="cert-manager installed"
MSG_EN["cert-manager 已存在"]="cert-manager already exists"
MSG_EN["检测到 IngressClass: %s"]="Detected IngressClass: %s"
MSG_EN["未检测到 IngressClass，将使用 Traefik"]="No IngressClass detected, will use Traefik"

# ===== 密码生成 =====
MSG_EN["Secret 名称: %s"]="Secret name: %s"
MSG_EN["交互模式: %s"]="Interactive mode: %s"
MSG_EN["应用 Secret 到集群..."]="Applying Secret to cluster..."
MSG_EN["Secret %s 已创建（仅存于集群，不落盘）"]="Secret %s created (cluster only, never written to disk)"
MSG_EN["generate-passwords.sh 未找到"]="generate-passwords.sh not found"
MSG_EN["前置条件检查失败"]="Prerequisites check failed"
MSG_EN["kubectl 或 helm 未安装"]="kubectl or helm not installed"
MSG_EN["openssl 未安装"]="openssl not installed"

# ===== Helm 安装 =====
MSG_EN["发现残留 release (状态: %s)，正在清理..."]="Found residual release (status: %s), cleaning up..."
MSG_EN["等待 release 相关 PVC 删除趋于稳定（最多 120s）..."]="Waiting for release-related PVCs to stabilize (max 120s)..."
MSG_EN["执行 Helm 安装..."]="Executing Helm installation..."
MSG_EN["Helm 安装失败！"]="Helm installation failed!"
MSG_EN["Helm Chart 已安装"]="Helm Chart installed"
MSG_EN["排查命令:"]="Troubleshooting commands:"
MSG_EN["回退命令:"]="Rollback commands:"

# ===== 安装验证 =====
MSG_EN["等待所有 pods 就绪 (超时 %ss)..."]="Waiting for all pods to be ready (timeout %ss)..."
MSG_EN["部分 pods 未在超时时间内就绪"]="Some pods did not become ready within timeout"
MSG_EN["Pod 状态:"]="Pod status:"
MSG_EN["Service 状态:"]="Service status:"
MSG_EN["Ingress 状态:"]="Ingress status:"
MSG_EN["未找到 Ingress 资源"]="No Ingress resources found"
MSG_EN["ITOM-Chart Production 安装完成！"]="ITOM-Chart Production installation complete!"
MSG_EN["ITOM-Chart 已安装，但部分服务尚未就绪"]="ITOM-Chart installed, but some services are not ready yet"

# ===== 访问信息 =====
MSG_EN["访问信息"]="Access Information"
MSG_EN["通过 Ingress 访问应用:"]="Access application via Ingress:"
MSG_EN["凭证存放位置"]="Credential Storage"
MSG_EN["所有密码仅存于集群 K8s Secret，磁盘不留任何明文："]="All passwords live only in the cluster's Kubernetes Secrets — no plaintext is left on disk:"
MSG_EN["# 服务密码（Keycloak / 数据库 / 加密密钥等）"]="# Service passwords (Keycloak / database / encryption keys, etc.)"
MSG_EN["# 镜像仓库凭证（离线/私仓模式）"]="# Image-registry credentials (offline / private-registry mode)"
MSG_EN["查看某个密码值（示例：数据库密码 postgres-password）："]="Read a password value (example: database password postgres-password):"
MSG_EN["交互输入过的密码（Keycloak sysadmin/tenant admin、数据库、registry）请自行记录；自动生成的密码用上面命令随时从 Secret 取回。事后改密码/补 AI 配置见安装指南「安装后修改」一节。"]="Keep the passwords you typed interactively (Keycloak sysadmin/tenant admin, database, registry) in your own records; auto-generated passwords can be retrieved from the Secret with the command above at any time. To change passwords / patch AI config post-install, see the 'Post-install changes' section of the installation guide."

# ===== 常用命令 =====
MSG_EN["常用命令"]="Common Commands"
MSG_EN["# 查看所有 pods"]="# View all pods"
MSG_EN["# 升级（修改 values 后）"]="# Upgrade (after modifying values)"
MSG_EN["# 卸载"]="# Uninstall"

# ===== 未知参数 =====
MSG_EN["未知参数: %s"]="Unknown argument: %s"
