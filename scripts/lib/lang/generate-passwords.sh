#!/bin/bash
# lib/lang/generate-passwords.sh — generate-passwords.sh 的中→英 词表片段
#
# 被 lib/i18n.sh 自动 source（lib/lang/*.sh）。key 必须与调用点字面串完全一致：
#   - _t "<key>"            → <key> 为脚本里出现的中文字面串
#   - tf "<key>" args...    → <key> 为中文 printf 格式串，占位符用 %s/%d
# zh 模式不需要条目（原样输出）；未命中的 key 自动回退中文，不会报错。

# ===== generate-passwords.sh：日志/提示（非插值，经 log_* / _t 包裹） =====
MSG_EN["ITOM-Chart 密码生成脚本"]="ITOM-Chart password generation script"
MSG_EN["openssl 未安装，请先安装 openssl"]="openssl is not installed; please install openssl first"
MSG_EN["交互式密码输入模式"]="Interactive password input mode"
MSG_EN["需要您亲自设置以下密码（不能为空，需输入两次确认一致）："]="Please set the following passwords yourself (must not be empty, enter twice to confirm):"
MSG_EN["Keycloak 密码策略: 至少 8 位，含大写字母、小写字母、数字、特殊字符"]="Keycloak password policy: at least 8 characters, with upper/lower-case letters, digits and special characters"
MSG_EN["使用参数传递的 Keycloak 管理员密码"]="Using the Keycloak admin password passed via parameter"
MSG_EN["使用参数传递的 Keycloak sysadmin 密码"]="Using the Keycloak sysadmin password passed via parameter"
MSG_EN["使用参数传递的 Keycloak 默认租户 admin 密码"]="Using the Keycloak default-tenant admin password passed via parameter"
MSG_EN["使用参数传递的外部数据库密码"]="Using the external database password passed via parameter"
MSG_EN["关键密码设置完成，其他内部服务密钥将自动生成"]="Key passwords set; other internal service secrets will be auto-generated"
MSG_EN["生成密码..."]="Generating passwords..."
MSG_EN["GitLab CI 模式：使用默认测试密码"]="GitLab CI mode: using default test passwords"
MSG_EN["所有密码已生成"]="All passwords generated"
MSG_EN["部分密码变量为空，无法生成 Secret"]="Some password variables are empty; cannot generate the Secret"
MSG_EN["输入被中断"]="Input interrupted"
MSG_EN["两次输入不一致，请重新输入"]="The two entries do not match; please re-enter"
MSG_EN["所有密码已生成并保存到凭证文件"]="All passwords generated and saved to the credentials file"
MSG_EN["请妥善保管这些密码文件！"]="Please keep these password files safe!"
MSG_EN["密码生成完成！"]="Password generation complete!"

# ===== generate-passwords.sh：带变量的插值消息（经 tf，key 含 %s） =====
MSG_EN["Release 名称: %s"]="Release name: %s"
MSG_EN["Secret 名称: %s"]="Secret name: %s"
MSG_EN["命名空间: %s"]="Namespace: %s"
MSG_EN["GitLab CI 模式: %s"]="GitLab CI mode: %s"
MSG_EN["交互模式: %s"]="Interactive mode: %s"
MSG_EN["未知参数: %s"]="Unknown argument: %s"
MSG_EN["创建 Kubernetes Secret YAML 文件: %s"]="Creating Kubernetes Secret YAML file: %s"
MSG_EN["Secret YAML 文件已创建: %s"]="Secret YAML file created: %s"
MSG_EN["创建凭证文件: %s"]="Creating credentials file: %s"
MSG_EN["凭证文件已创建: %s"]="Credentials file created: %s"
MSG_EN["创建 Keycloak cmdb.json 配置文件: %s"]="Creating Keycloak cmdb.json configuration file: %s"
MSG_EN["Keycloak cmdb.json 配置文件已创建: %s"]="Keycloak cmdb.json configuration file created: %s"
MSG_EN["凭证文件: %s"]="Credentials file: %s"
MSG_EN["Secret YAML: %s"]="Secret YAML: %s"
MSG_EN["输入%s密码: "]="Enter %s password: "
MSG_EN["确认%s密码（再输入一次）: "]="Confirm %s password (enter again): "
MSG_EN["%s密码不能为空，请重新输入"]="%s password must not be empty; please re-enter"
MSG_EN["密码不符合策略: %s，请重新输入（至少 8 位，含大写/小写/数字/特殊字符）"]="Password does not meet policy: %s; please re-enter (at least 8 chars, with upper/lower-case letters, digits and special characters)"
MSG_EN["已设置%s密码"]="%s password set"
MSG_EN["将 %s 保存到安全的位置"]="Save %s to a secure location"
MSG_EN["将 %s 放置到 itom-chart/configs/keycloak/clients/ 目录"]="Place %s into the itom-chart/configs/keycloak/clients/ directory"

# ===== generate-passwords.sh：密码策略校验原因（validate_keycloak_password，经 _t） =====
MSG_EN["至少 8 个字符"]="at least 8 characters"
MSG_EN["至少 1 个大写字母"]="at least 1 upper-case letter"
MSG_EN["至少 1 个小写字母"]="at least 1 lower-case letter"
MSG_EN["至少 1 个数字"]="at least 1 digit"
MSG_EN["至少 1 个特殊字符"]="at least 1 special character"

# ===== generate-passwords.sh：直接 echo 的提示行（经 _t） =====
MSG_EN["Keycloak 系统租户 sysadmin 密码（租户 100000000）"]="Keycloak system-tenant sysadmin password (tenant 100000000)"
MSG_EN["Keycloak 默认租户 admin 密码（租户 100000001）"]="Keycloak default-tenant admin password (tenant 100000001)"
MSG_EN["外部数据库密码（须与 DBA 创建用户时设定的真实密码一致）"]="External database password (must match the real password the DBA set when creating the user)"
MSG_EN["其他内部服务密钥将自动生成"]="Other internal service secrets will be auto-generated"
MSG_EN["建议操作:"]="Recommended actions:"
MSG_EN["使用密码管理器存储这些密码"]="Store these passwords in a password manager"
MSG_EN["在生产环境中，请使用强密码并定期轮换"]="In production, use strong passwords and rotate them periodically"
