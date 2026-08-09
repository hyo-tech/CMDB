#!/bin/bash
# lib/lang/install-community-docker-compose.sh — install-community-docker-compose.sh 词表片段
# 被 lib/i18n.sh 在 bash 4+ 下 source

# ===== AI 模型配置（社区版 .env 文件）=====
MSG_EN["AI 模型配置: API Key 已设置（AI 功能可用）"]="AI model config: API key is set (AI features available)"
MSG_EN["AI 模型配置缺失：.env 文件中 ITOM_MODEL_API_KEY 未设置"]="AI model config missing: ITOM_MODEL_API_KEY is not set in .env file"
MSG_EN["AI 相关功能（AI 助手 / AI 驱动的运维）将不可用，直到补齐模型配置"]="AI-related features (AI assistant / AI-driven operations) will be unavailable until the model config is provided"
MSG_EN["补齐方式：编辑 %s 填 ITOM_MODEL_{NAME,BASE_URL,API_KEY}"]="To fix: edit %s and fill ITOM_MODEL_{NAME,BASE_URL,API_KEY}"
MSG_EN["  不启用 AI 继续安装? [y/N]: "]="  Continue without AI? [y/N]: "
MSG_EN["安装已取消"]="Installation cancelled"
