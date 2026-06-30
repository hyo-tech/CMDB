#!/bin/bash
#
# Keycloak Realm Configuration Setup
#
# Reads passwords from environment variables, substitutes placeholders
# in the JSON template, and generates the final realm import file.
#
# Environment Variables:
#   KEYCLOAK_ADMIN_PASSWORD              - Admin user password (default: admin)
#   KEYCLOAK_CMDB_UI_SECRET              - cmdb_ui client secret (from KEYCLOAK_CLIENT_SECRET)
#   KEYCLOAK_CMDB_BACKEND_SECRET         - cmdb_backend client secret (from KEYCLOAK_SERVICE_ACCOUNT_CLIENT_SECRET)

set -e

# Default values
ADMIN_PASSWORD="${KEYCLOAK_ADMIN_PASSWORD:-admin}"
CMDB_UI_SECRET="${KEYCLOAK_CLIENT_SECRET}"
CMDB_BACKEND_SECRET="${KEYCLOAK_SERVICE_ACCOUNT_CLIENT_SECRET}"

# Paths
IMPORT_DIR="/opt/keycloak/data/import"
TEMPLATE_FILE="/templates/cmdb.template"
OUTPUT_FILE="${IMPORT_DIR}/cmdb.json"

# Ensure import directory exists
mkdir -p "$IMPORT_DIR"

echo "=========================================="
echo "Keycloak Realm Configuration Setup"
echo "=========================================="

# Check template exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "ERROR: Template file not found: $TEMPLATE_FILE"
    exit 1
fi

echo "Admin password: ${ADMIN_PASSWORD:0:8}..."
echo "Template: $TEMPLATE_FILE"
echo "Output:   $OUTPUT_FILE"

# Use sed to replace placeholders (busybox compatible)
# Use | as delimiter to avoid conflicts with password special characters
sed -e "s|__KEYCLOAK_ADMIN_PASSWORD__|${ADMIN_PASSWORD}|g" \
    -e "s|__KEYCLOAK_CMDB_UI_SECRET__|${CMDB_UI_SECRET}|g" \
    -e "s|__KEYCLOAK_CMDB_BACKEND_SECRET__|${CMDB_BACKEND_SECRET}|g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

echo "Realm configuration generated successfully"
echo "Output file size: $(wc -c < "$OUTPUT_FILE" | tr -d ' ') bytes"

# Validate JSON - try python3 first, then basic grep check
if command -v python3 &> /dev/null; then
    if python3 -m json.tool "$OUTPUT_FILE" > /dev/null 2>&1; then
        echo "JSON validation passed"
    else
        echo "ERROR: Generated JSON is invalid"
        exit 1
    fi
else
    # Basic validation: ensure placeholders were replaced (no __ left)
    if grep -q '__KEYCLOAK_' "$OUTPUT_FILE"; then
        echo "ERROR: Placeholders not fully replaced"
        exit 1
    fi
    echo "JSON basic validation passed"
fi

echo "=========================================="
