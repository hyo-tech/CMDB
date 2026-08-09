#!/bin/bash
# lib/lang/update-secret.sh — update-secret.sh 词表片段
# 被 lib/i18n.sh 在 bash 4+ 下 source

# ===== 参数校验 / 公共 =====
MSG_EN["缺少子命令（db-password / registry-password / ai-model）"]="Missing subcommand (db-password / registry-password / ai-model)"
MSG_EN["缺少必填参数: -n/--namespace"]="Missing required argument: -n/--namespace"
MSG_EN["未知参数: %s"]="Unknown argument: %s"
MSG_EN["未知子命令: %s"]="Unknown subcommand: %s"
MSG_EN["Release: %s / 命名空间: %s / Secret: %s"]="Release: %s / Namespace: %s / Secret: %s"
MSG_EN["操作: %s"]="Operation: %s"
MSG_EN["kubectl 未安装"]="kubectl is not installed"
MSG_EN["helm 未安装"]="helm is not installed"
MSG_EN["完成"]="Done"
MSG_EN["输入被中断"]="Input interrupted"

# ===== 通用密码读取 =====
MSG_EN["输入%s: "]="Enter %s: "
MSG_EN["%s不能为空，请重新输入"]="%s cannot be empty, please try again"
MSG_EN["确认%s（再输入一次）: "]="Confirm %s (enter again): "
MSG_EN["两次输入不一致，请重新输入"]="Passwords do not match, please try again"

# ===== Secret patch =====
MSG_EN["更新 Secret %s 的 %s 失败"]="Failed to update Secret %s key %s"

# ===== db-password =====
MSG_EN["修改外部数据库密码"]="Rotate external database password"
MSG_EN["新的数据库密码"]="new database password"
MSG_EN["未提供新的数据库密码（用 --password-stdin 或环境变量 NEW_DB_PASSWORD）"]="No new database password provided (use --password-stdin or env NEW_DB_PASSWORD)"
MSG_EN["Secret %s 不存在，请确认 Release/命名空间正确"]="Secret %s does not exist; check the release name / namespace"
MSG_EN["顺序很重要：必须先在 PostgreSQL 改密码，再让本脚本更新 Secret 并滚动，否则新旧 Pod 都连不上库。"]="Order matters: change the password in PostgreSQL FIRST, then let this script update the Secret and roll pods — otherwise both old and new pods fail to connect."
MSG_EN["请 DBA 先在 PostgreSQL 执行（用户名/库名按实际）："]="Have the DBA run this in PostgreSQL first (adjust user/db names as needed):"
MSG_EN["  PostgreSQL 已改好? 回车继续（滚动 Deployment，会有短暂连接中断），Ctrl-C 中止: "]="  PostgreSQL updated? Press Enter to continue (deployments will roll, brief connection blip), Ctrl-C to abort: "
MSG_EN["更新 Secret %s 的 postgres-password ..."]="Updating Secret %s key postgres-password ..."
MSG_EN["Secret 已更新"]="Secret updated"
MSG_EN["滚动受影响的 Deployment（用新密码重连数据库）..."]="Rolling affected deployments (reconnect with the new password)..."
MSG_EN["等待滚动完成..."]="Waiting for rollout to complete..."
MSG_EN["  %s 就绪"]="  %s ready"
MSG_EN["  %s 未在超时内就绪，请用 kubectl logs deploy/%s 排查"]="  %s not ready within timeout; check with kubectl logs deploy/%s"
MSG_EN["数据库密码已轮换完成"]="Database password rotation complete"
MSG_EN["若安装时 my-values.yaml 把 externalDatabase.password 填成了非空值，chart 会读那个明文值而不读 Secret——此时需把该字段改回空字符串再 helm upgrade。"]="If externalDatabase.password was set to a non-empty value in my-values.yaml at install time, the chart reads that plaintext value instead of the Secret — set it back to empty and run helm upgrade."

# ===== registry-password =====
MSG_EN["修改镜像仓库密码"]="Rotate image registry password"
MSG_EN["新的 registry 密码"]="new registry password"
MSG_EN["未提供新的 registry 密码（用 --password-stdin 或环境变量 NEW_REGISTRY_PASSWORD）"]="No new registry password provided (use --password-stdin or env NEW_REGISTRY_PASSWORD)"
MSG_EN["无法确定 registry 地址/用户名。请用 --registry <HOST> --user <NAME> 显式传入。"]="Could not determine registry host / username. Pass them explicitly via --registry <HOST> --user <NAME>."
MSG_EN["Registry: %s（用户: %s）"]="Registry: %s (user: %s)"
MSG_EN["重建 imagePullSecret 失败"]="Failed to recreate imagePullSecret"
MSG_EN["imagePullSecret %s 已用新密码重建"]="imagePullSecret %s recreated with the new password"
MSG_EN["无需重启：已运行的 Pod 不受影响，新调度的 Pod 会用新凭证拉镜像。"]="No restart needed: running pods are unaffected; newly scheduled pods will pull images with the new credentials."

# ===== ai-model =====
MSG_EN["补/改 AI 模型配置"]="Patch AI model configuration"
MSG_EN["--disable 与 --api-key 同时给出，将以 --disable 为准（清空 key）"]="Both --disable and --api-key given; --disable wins (key cleared)"
MSG_EN["AI 模型 API Key"]="AI model API key"
MSG_EN["未提供任何 AI 配置（用 --api-key / --model-name / --base-url，或 --disable 关闭 AI）"]="No AI config provided (use --api-key / --model-name / --base-url, or --disable to turn AI off)"
MSG_EN["未找到 Chart（用于 helm upgrade）。请用 -c/--chart 显式指定，或确认安装包内 charts/itom-*.tgz 存在。"]="Chart not found (needed for helm upgrade). Specify it via -c/--chart, or ensure charts/itom-*.tgz exists in the install package."
MSG_EN["Chart: %s"]="Chart: %s"
MSG_EN["执行 helm upgrade --reuse-values（仅覆盖 AI 字段，其余值保留）..."]="Running helm upgrade --reuse-values (overrides only AI fields, other values preserved)..."
MSG_EN["helm upgrade 失败"]="helm upgrade failed"
MSG_EN["AI 配置已更新，ai-agent Deployment 将自动滚动"]="AI config updated; the ai-agent Deployment will roll automatically"
MSG_EN["查看滚动状态: kubectl rollout status deploy/itom-ai-agent -n %s"]="Check rollout status: kubectl rollout status deploy/itom-ai-agent -n %s"
MSG_EN["注: API Key 仍会存入 helm release（helm get values 可见）。改 chart 让 AI Key 走 Secret 是更大的改动，不在本工具范围。"]="Note: the API key is still stored in the helm release (visible via helm get values). Routing the AI key through a Secret requires a chart change and is out of scope for this tool."
MSG_EN["如需配置 per-task 专用模型（ITOM_MEMORY_* / ITOM_ARTIFACT_* / ITOM_PII_LLM_*），请编辑 my-values.yaml 的 services.aiAgent.env 后 helm upgrade --reuse-values -f my-values.yaml -f <storage-overlay>。"]="To configure per-task models (ITOM_MEMORY_* / ITOM_ARTIFACT_* / ITOM_PII_LLM_*), edit services.aiAgent.env in my-values.yaml, then run helm upgrade --reuse-values -f my-values.yaml -f <storage-overlay>."
