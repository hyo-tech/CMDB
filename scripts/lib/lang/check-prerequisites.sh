#!/bin/bash
# lib/lang/check-prerequisites.sh — check-prerequisites.sh 中→英 词表片段
# （被 lib/i18n.sh 在 bash 4+ 下自动 source：lib/lang/*.sh）
#
# 约定:
#   - key = 脚本里出现的「中文字面串」（_t 调用）或「中文 printf 格式串」（tf 调用，占位符 %s）。
#   - zh 模式不需要任何条目（原样输出中文）；这里只写 en 翻译。
#   - 未命中的 key 自动回退中文，不会报错。
#   - key 必须与调用点字符串逐字一致（含全角括号（）、中文标点，、。！、空格、>= 等均需精确匹配）。

# ----- 区段 / 状态标题（log_section，_t 包裹）-----
MSG_EN["ITOM-Chart 前置条件检查"]="ITOM-Chart Prerequisites Check"
MSG_EN["1. 检查必需工具"]="1. Checking required tools"
MSG_EN["2. 检查集群连接"]="2. Checking cluster connectivity"
MSG_EN["3. 检查节点状态"]="3. Checking node status"
MSG_EN["4. 检查节点资源"]="4. Checking node resources"
MSG_EN["5. 检查存储类"]="5. Checking storage classes"
MSG_EN["6. 检查 cert-manager"]="6. Checking cert-manager"
MSG_EN["7. 检查 Ingress Controller"]="7. Checking Ingress Controller"
MSG_EN["8. 生产环境额外检查"]="8. Additional production checks"
MSG_EN["9. 检查命名空间"]="9. Checking namespace"
MSG_EN["10. 检查磁盘空间"]="10. Checking disk space"
MSG_EN["11. 检查网络连接"]="11. Checking network connectivity"
MSG_EN["检查总结"]="Check summary"
MSG_EN["生产环境"]="Production"
MSG_EN["社区版环境"]="Community edition"

# ----- 工具检查 -----
MSG_EN["kubectl 未安装"]="kubectl is not installed"
MSG_EN["kubectl 版本检查通过"]="kubectl version check passed"
MSG_EN["kubectl 版本检查失败"]="kubectl version check failed"
MSG_EN["helm 未安装"]="helm is not installed"
MSG_EN["helm 版本 >= 3.0"]="helm version >= 3.0"
MSG_EN["helm 版本过低"]="helm version is too low"
MSG_EN["openssl 已安装"]="openssl is installed"
MSG_EN["openssl 未安装（无法生成密码）"]="openssl is not installed (cannot generate passwords)"

# ----- 集群 / 节点 -----
MSG_EN["可以连接到 Kubernetes 集群"]="Can connect to the Kubernetes cluster"
MSG_EN["无法连接到 Kubernetes 集群"]="Cannot connect to the Kubernetes cluster"
MSG_EN["所有节点状态为 Ready"]="All nodes are in Ready state"
MSG_EN["无法获取节点信息"]="Cannot retrieve node information"

# ----- 存储类 -----
MSG_EN["发现 local-path 存储类（社区版需要）"]="local-path storage class found (required by community edition)"
MSG_EN["未发现 local-path 存储类（社区版需要，将尝试安装）"]="local-path storage class not found (required by community edition; will attempt to install)"
MSG_EN["未发现任何存储类（安装脚本将尝试安装 local-path）"]="No storage class found (the install script will attempt to install local-path)"
MSG_EN["未发现任何存储类"]="No storage class found"

# ----- cert-manager / ingress -----
MSG_EN["cert-manager 已安装"]="cert-manager is installed"
MSG_EN["cert-manager 命名空间存在但无 pods"]="cert-manager namespace exists but has no pods"
MSG_EN["cert-manager 未安装（安装脚本将自动安装）"]="cert-manager is not installed (the install script will install it automatically)"
MSG_EN["未发现 IngressClass（安装脚本将尝试安装 ingress-nginx）"]="No IngressClass found (the install script will attempt to install ingress-nginx)"

# ----- 生产环境额外检查 -----
MSG_EN["生产环境存储类充足"]="Sufficient storage classes for production"
MSG_EN["生产环境建议使用多个存储类（数据、日志分离）"]="Production recommends multiple storage classes (separate data and logs)"
MSG_EN["未配置外部数据库（生产环境推荐使用外部数据库）"]="External database not configured (production recommends an external database)"

# ----- 网络 -----
MSG_EN["可以访问 Kubernetes API"]="Can access the Kubernetes API"
MSG_EN["无法直接访问 Kubernetes API（可能正常，kubectl 使用代理）"]="Cannot access the Kubernetes API directly (may be normal; kubectl uses a proxy)"

# ----- 总结 -----
MSG_EN["所有关键检查通过！可以继续安装。"]="All critical checks passed! You can proceed with installation."

# ----- 插值消息（tf 格式串，占位符 %s）-----
MSG_EN["未知参数: %s"]="Unknown argument: %s"
MSG_EN["命名空间: %s"]="Namespace: %s"
MSG_EN["模式: %s"]="Mode: %s"
MSG_EN["kubectl 已安装 (版本: %s)"]="kubectl is installed (version: %s)"
MSG_EN["helm 已安装 (版本: %s)"]="helm is installed (version: %s)"
MSG_EN["集群有 %s 个节点"]="Cluster has %s nodes"
MSG_EN["部分节点状态异常 (%s/%s Ready)"]="Some nodes are not healthy (%s/%s Ready)"
MSG_EN["CPU 资源检查通过 (节点数: %s, 估计 >= %s 核心)"]="CPU resource check passed (nodes: %s, estimated >= %s cores)"
MSG_EN["CPU 资源充足 (节点数: %s, 估计 >= %s 核心)"]="CPU resources are sufficient (nodes: %s, estimated >= %s cores)"
MSG_EN["CPU 资源较少 (估计: %s 核心，推荐 >= 4 核心)"]="CPU resources are low (estimated: %s cores, recommended >= 4 cores)"
MSG_EN["发现 %s 个存储类:"]="Found %s storage classes:"
MSG_EN["发现 %s 个 IngressClass:"]="Found %s IngressClasses:"
MSG_EN["外部数据库主机已配置: %s"]="External database host configured: %s"
MSG_EN["命名空间 %s 已存在"]="Namespace %s already exists"
MSG_EN["命名空间 %s 不存在（将自动创建）"]="Namespace %s does not exist (will be created automatically)"
MSG_EN["命名空间 %s 中已有 %s 个 pods"]="Namespace %s already has %s pods"
MSG_EN["磁盘空间可用 (社区版环境: %sG)"]="Disk space available (community edition: %sG)"
MSG_EN["磁盘空间较少 (可用: %sG，社区版推荐 >= 10G)"]="Disk space is low (available: %sG, community edition recommends >= 10G)"
MSG_EN["磁盘空间充足 (可用: %sG)"]="Disk space is sufficient (available: %sG)"
MSG_EN["磁盘空间较少 (可用: %sG，推荐 >= 50G)"]="Disk space is low (available: %sG, recommended >= 50G)"
MSG_EN["磁盘空间不足 (可用: %sG，需要 >= 20G)"]="Disk space is insufficient (available: %sG, required >= 20G)"
MSG_EN["有 %s 个警告，建议修复后再安装。"]="There are %s warnings; please fix them before installing."
MSG_EN["有 %s 个检查失败，请修复后再安装。"]="%s checks failed; please fix them before installing."
MSG_EN["总检查项: %s"]="Total checks: %s"
MSG_EN["通过: %s"]="Passed: %s"
MSG_EN["警告: %s"]="Warnings: %s"
MSG_EN["失败: %s"]="Failed: %s"
