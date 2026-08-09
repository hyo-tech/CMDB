#!/bin/bash
# lib/i18n.sh — 安装脚本中英文双语支持（zh / en）
#
# 语言判定顺序（先命中先生效）:
#   1. 脚本预扫到的 --lang zh|en（或调用方显式 export ITOM_LANG）
#   2. 已设置的 ITOM_LANG 环境变量
#   3. 操作系统 locale 自动检测：LC_ALL > LC_MESSAGES > LANG（zh*→zh，en*→en）
#   4. 兜底：zh（保护现有中文客户，locale 为 C/空/无法判定时不变）
#
# 机制（bash 4+ 关联数组，仓库脚本已普遍使用 declare -A）:
#   - 词表 lib/messages.sh 用关联数组 MSG_EN 把「中文字面串」映射到英文。
#   - zh 模式：原样输出调用方传入的中文（无需词表条目）。
#   - en 模式：查 MSG_EN 命中则输出英文，未命中则回退中文（绝不报错/中断脚本）。
#   - 因此 log_info "中文" 这类调用只需让 log_* 内部包一层 _t，调用点无需改动；
#     仅「带变量的插值串」「直接 echo/read -p/printf」「多行 usage heredoc」需调整。
#
# 用法:
#   source "${SCRIPT_DIR}/lib/i18n.sh"
#   log_info()  { echo -e "... $(_t "$1")"; }        # 普通串：内部包 _t
#   log_info "$(tf "进度: %s/%s" "$cur" "$total")"   # 插值串：用 tf + printf 格式
#   read -p "$(_t "继续安装? [y/N]: ")" ans           # 直接提示：包 _t

# 1) 解析语言（仅当脚本预扫/env 都没给时才自动检测 locale）
if [ -z "${ITOM_LANG:-}" ]; then
    case "${LC_ALL:-${LC_MESSAGES:-${LANG:-}}}" in
        zh*|ZH*) ITOM_LANG=zh ;;
        en*|EN*) ITOM_LANG=en ;;
        *)       ITOM_LANG=zh ;;   # 兜底中文
    esac
fi
# 规范化
case "$ITOM_LANG" in
    en|EN|en_*|EN_*|english|English|ENGLISH) ITOM_LANG=en ;;
    *)                                         ITOM_LANG=zh ;;
esac
export ITOM_LANG   # 让子脚本（generate-certs / generate-passwords / check-prerequisites）继承同一语言

# 2) 载入词表（bash 4+ 关联数组）。bash 3 无关联数组 → 降级为不翻译（原样中文），不报错。
ITOM_I18N_OK=0
if [ "${BASH_VERSINFO[0]:-0}" -ge 4 ]; then
    declare -A MSG_EN 2>/dev/null || MSG_EN=()
    _i18n_cat="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/messages.sh"
    if [ -f "$_i18n_cat" ]; then
        # shellcheck source=/dev/null
        source "$_i18n_cat"
        # 各脚本词表片段（lib/lang/*.sh），便于分脚本维护、避免多人/多代理改同一文件
        for _frag in "$(dirname "$_i18n_cat")"/lang/*.sh; do
            [ -f "$_frag" ] && { # shellcheck source=/dev/null
                source "$_frag"; }
        done
        ITOM_I18N_OK=1
    fi
fi

# 3) 翻译函数
# _t <string>：翻译「不带变量」的整条消息
_t() {
    if [ "$ITOM_LANG" = en ] && [ "$ITOM_I18N_OK" = 1 ]; then
        printf '%s' "${MSG_EN[$1]:-$1}"
    else
        printf '%s' "$1"
    fi
}

# tf <printf-format> [args...]：翻译「带变量」的消息（占位符用 %s/%d 等）
tf() {
    local fmt="$1"; shift
    if [ "$ITOM_LANG" = en ] && [ "$ITOM_I18N_OK" = 1 ]; then
        fmt="${MSG_EN[$fmt]:-$fmt}"
    fi
    # shellcheck disable=SC2059
    printf -- "$fmt" "$@"
}

# 方便脚本预扫 --lang（在正式参数解析前调用，让 usage()/早期报错也翻译）
# 用法：i18n_prescan_lang "$@"  （在 source 本文件之前调用，设置 ITOM_LANG）
i18n_prescan_lang() {
    local _expect=0 _a
    for _a in "$@"; do
        if [ "$_expect" = 1 ]; then
            case "$_a" in zh|en|zh-CN|zh_CN|en-US|en_US) ITOM_LANG="${_a%%-*}"; ITOM_LANG="${ITOM_LANG%%_*}";; esac
            _expect=0
        fi
        [ "$_a" = "--lang" ] && _expect=1
    done
    return 0   # 始终成功，避免被 set -e 误杀
}
