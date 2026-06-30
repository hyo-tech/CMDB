#!/bin/bash
set -e

# 获取脚本所在目录
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
CERT_DIR="${SCRIPT_DIR}/../conf/certificates"
mkdir -p "$CERT_DIR"

# 获取主机名和主IP
HOSTNAME=$(hostname)
PRIMARY_IP=$(hostname -I | awk '{print $1}')

# 生成openssl配置
cat > "${CERT_DIR}/openssl.cnf" <<CONF
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
CN = $HOSTNAME

[v3_req]
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = DNS:$HOSTNAME,IP:$PRIMARY_IP
CONF

# 清理旧证书
rm -f "${CERT_DIR}"/dev.{crt,key,openssl.cnf}

# 生成新证书
openssl req -x509 -newkey rsa:4096 \
  -keyout "${CERT_DIR}/dev.key" \
  -out "${CERT_DIR}/dev.crt" \
  -days 365 -nodes \
  -config "${CERT_DIR}/openssl.cnf"

# 设置权限
chmod 644 "${CERT_DIR}"/dev.*

echo "证书已成功生成:"
echo "- 证书文件: ${CERT_DIR}/dev.crt" 
echo "- 密钥文件: ${CERT_DIR}/dev.key"
echo "- 有效期: 365天"
echo "- 包含主机名: $HOSTNAME"
echo "- 包含IP地址: $PRIMARY_IP"