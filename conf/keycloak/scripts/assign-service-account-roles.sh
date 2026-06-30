#!/bin/sh
#
# Keycloak Service Account Role Assignment Script
#
# This script assigns realm-management roles to a service account user.
# It can be used as:
#   - Kubernetes Init Container (runs once, exits)
#   - Docker Compose service (runs once, exits)
#
# Environment Variables:
#   KEYCLOAK_ADMIN         - Admin username (default: admin)
#   KEYCLOAK_ADMIN_PASSWORD - Admin password (default: admin)
#   KEYCLOAK_URL           - Keycloak base URL (default: https://keycloak:8443/idm)
#   REALM_NAME             - Target realm name (default: 100000001)
#   SERVICE_ACCOUNT_CLIENT_ID - Service account client ID (default: cmdb_backend)
#   ONCE_ONLY              - Exit after first execution (default: true)
#
# NOTE: We do NOT use 'set -e' because it causes scripts to exit prematurely
# when using command substitution with commands that might fail. Instead, we
# handle errors explicitly with || and if statements.

# Default values
KEYCLOAK_ADMIN="${KEYCLOAK_ADMIN:-admin}"
KEYCLOAK_ADMIN_PASSWORD="${KEYCLOAK_ADMIN_PASSWORD:-admin}"
KEYCLOAK_URL="${KEYCLOAK_URL:-https://keycloak:8443/idm}"
REALM_NAME="${REALM_NAME:-100000001}"
SERVICE_ACCOUNT_CLIENT_ID="${SERVICE_ACCOUNT_CLIENT_ID:-cmdb_backend}"
ONCE_ONLY="${ONCE_ONLY:-true}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions - output to stderr to avoid being captured in command substitution
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1" >&2
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

log_debug() {
    # Only show debug messages if DEBUG is set
    if [ "$DEBUG" = "true" ]; then
        echo -e "${NC}[DEBUG]${NC} $1" >&2
    fi
}

# Wait for Keycloak to be ready
wait_for_keycloak() {
    log_info "Waiting for Keycloak to be ready..."

    local max_attempts=90
    local attempt=0

    while [ $attempt -lt $max_attempts ]; do
        # Try to get admin token - this is the most reliable check
        # If we can get a token, Keycloak is ready
        local token_response=$(curl -k -s -X POST \
            "${KEYCLOAK_URL}/realms/master/protocol/openid-connect/token" \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "username=${KEYCLOAK_ADMIN}" \
            -d "password=${KEYCLOAK_ADMIN_PASSWORD}" \
            -d "grant_type=password" \
            -d "client_id=admin-cli" \
            --connect-timeout 5 \
            --max-time 10 2>&1)

        # Check if we got an access_token (successful authentication)
        if echo "$token_response" | grep -q '"access_token"'; then
            log_info "Keycloak is ready! (admin token obtained)"
            return 0
        fi

        # Check for specific errors
        if echo "$token_response" | grep -q "Connection refused"; then
            # Keycloak not started yet
            :
        elif echo "$token_response" | grep -q "SSL"; then
            # SSL error - might be ready but certificate issue
            log_warn "SSL error encountered, trying with -k..."
        fi

        attempt=$((attempt + 1))
        echo -n "."
        sleep 2
    done

    log_error "Timeout waiting for Keycloak to be ready"
    log_error "Last response: $token_response"
    return 1
}

# Get admin token
get_admin_token() {
    log_info "Getting admin token..."

    local token_response
    token_response=$(curl -k -s -X POST \
        "${KEYCLOAK_URL}/realms/master/protocol/openid-connect/token" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "username=${KEYCLOAK_ADMIN}" \
        -d "password=${KEYCLOAK_ADMIN_PASSWORD}" \
        -d "grant_type=password" \
        -d "client_id=admin-cli" \
        --connect-timeout 10 \
        --max-time 30 2>&1) || true

    local curl_exit=$?
    if [ $curl_exit -ne 0 ]; then
        log_error "curl failed with exit code: $curl_exit"
        log_error "Response: $token_response"
        return 1
    fi

    local access_token=$(echo "$token_response" | grep -o '"access_token":"[^"]*"' | cut -d'"' -f4)

    if [ -z "$access_token" ]; then
        log_error "Failed to extract access token from response"
        log_error "Response: $token_response"
        return 1
    fi

    echo "$access_token"
}

# Get service account user ID
get_service_account_user_id() {
    local token="$1"
    local service_account_username="service-account-${SERVICE_ACCOUNT_CLIENT_ID}"

    log_info "Getting service account user ID for: $service_account_username"

    local api_url="${KEYCLOAK_URL}/admin/realms/${REALM_NAME}/users?username=${service_account_username}"
    log_debug "API URL: $api_url"

    local users_response
    local curl_exit

    # Use || true to prevent command failure from exiting the function prematurely
    users_response=$(curl -k -s -X GET \
        "$api_url" \
        -H "Authorization: Bearer ${token}" \
        --connect-timeout 10 \
        --max-time 30 2>&1) || true

    curl_exit=$?

    log_debug "curl exit code: $curl_exit"
    log_debug "Response (first 300 chars): $(echo "$users_response" | head -c 300)"

    if [ $curl_exit -ne 0 ]; then
        log_error "curl command failed with exit code: $curl_exit"
        log_error "Response: $users_response"
        return 1
    fi

    local user_id=$(echo "$users_response" | grep -o '"id":"[^"]*"' | head -n 1 | cut -d'"' -f4)

    if [ -z "$user_id" ]; then
        log_warn "Service account user not found: $service_account_username"
        log_info "Attempting to create service account user..."

        # Get the client ID first
        local client_id
        client_id=$(get_client_id "$token" "$SERVICE_ACCOUNT_CLIENT_ID")
        local get_client_exit=$?
        log_debug "get_client_id exit code: $get_client_exit, result: $client_id"
        if [ $get_client_exit -ne 0 ] || [ -z "$client_id" ]; then
            log_error "Failed to get client ID for: $SERVICE_ACCOUNT_CLIENT_ID"
            return 1
        fi

        # Create service account user
        user_id=$(create_service_account_user "$token" "$client_id")
        local create_exit=$?
        log_debug "create_service_account_user exit code: $create_exit, result: $user_id"
        if [ $create_exit -ne 0 ] || [ -z "$user_id" ]; then
            log_error "Failed to create service account user"
            return 1
        fi
    fi

    log_info "Service account user ID: $user_id"
    echo "$user_id"
}

# Get client ID by clientId
get_client_id() {
    local token=$1
    local client_id=$2

    log_debug "Getting client ID for: $client_id"

    local clients_response
    clients_response=$(curl -k -s -X GET \
        "${KEYCLOAK_URL}/admin/realms/${REALM_NAME}/clients?clientId=${client_id}" \
        -H "Authorization: Bearer ${token}" \
        --connect-timeout 10 \
        --max-time 30 2>&1) || true

    local curl_exit=$?
    if [ $curl_exit -ne 0 ]; then
        log_error "Failed to query clients API (curl exit: $curl_exit)"
        log_error "Response: $clients_response"
        return 1
    fi

    local id=$(echo "$clients_response" | grep -o '"id":"[^"]*"' | head -n 1 | cut -d'"' -f4)

    if [ -z "$id" ]; then
        log_error "Client not found: $client_id"
        log_error "Response: $clients_response"
        return 1
    fi

    log_debug "Found client ID: $id for $client_id"
    echo "$id"
}

# Create service account user for a client
create_service_account_user() {
    local token=$1
    local client_id=$2
    local service_account_username="service-account-${SERVICE_ACCOUNT_CLIENT_ID}"

    log_info "Creating service account user for client: $SERVICE_ACCOUNT_CLIENT_ID"
    log_info "Client UUID: $client_id"

    # In Keycloak 26, the service account user is created automatically when
    # service account is enabled on the client. Let's try to find it first.
    # If not found, we'll try to trigger creation via the service account endpoint.

    log_info "Checking if service account user already exists..."
    local users_response
    users_response=$(curl -k -s -X GET \
        "${KEYCLOAK_URL}/admin/realms/${REALM_NAME}/users?username=${service_account_username}&exact=true" \
        -H "Authorization: Bearer ${token}" \
        --connect-timeout 10 \
        --max-time 30 2>&1) || true

    local user_id=$(echo "$users_response" | grep -o '"id":"[^"]*"' | head -n 1 | cut -d'"' -f4)

    if [ -n "$user_id" ]; then
        log_info "Service account user already exists: $user_id"
        echo "$user_id"
        return 0
    fi

    log_info "Service account user not found, trying to get service account from client..."

    # Try to get the service account user via the client's service-account endpoint
    # This is the standard Keycloak API endpoint for service accounts
    local sa_response
    sa_response=$(curl -k -s -X GET \
        "${KEYCLOAK_URL}/admin/realms/${REALM_NAME}/clients/${client_id}/service-account-user" \
        -H "Authorization: Bearer ${token}" \
        --connect-timeout 10 \
        --max-time 30 2>&1) || true

    log_debug "Service account endpoint response: $(echo "$sa_response" | head -c 300)"

    user_id=$(echo "$sa_response" | grep -o '"id":"[^"]*"' | head -n 1 | cut -d'"' -f4)

    if [ -n "$user_id" ]; then
        log_info "Service account user found via client endpoint: $user_id"
        echo "$user_id"
        return 0
    fi

    log_error "Failed to find or create service account user"
    log_error "Service account may not be enabled on client: $SERVICE_ACCOUNT_CLIENT_ID"
    log_error "Please ensure the client has 'Service Accounts Enabled' set to ON in Keycloak"
    return 1
}

# Get role representations
get_role_representations() {
    local token=$1
    local client_id=$2
    shift 2
    local role_names="$@"

    local roles_json="["
    local found_count=0

    local first=true
    for role_name in $role_names; do
        local role_response
        role_response=$(curl -k -s -X GET \
            "${KEYCLOAK_URL}/admin/realms/${REALM_NAME}/clients/${client_id}/roles/${role_name}" \
            -H "Authorization: Bearer ${token}" \
            --connect-timeout 10 \
            --max-time 30 2>&1) || true

        local role_id=$(echo "$role_response" | grep -o '"id":"[^"]*"' | head -n 1 | cut -d'"' -f4)

        if [ -n "$role_id" ]; then
            if [ "$first" = true ]; then
                first=false
            else
                roles_json="${roles_json},"
            fi
            roles_json="${roles_json}{\"id\":\"${role_id}\",\"name\":\"${role_name}\"}"
            log_info "  Found role: ${role_name} (id: ${role_id})"
            found_count=$((found_count + 1))
        else
            log_warn "  Role not found: ${role_name}"
        fi
    done

    roles_json="${roles_json}]"

    if [ $found_count -eq 0 ]; then
        log_warn "No roles were found"
    else
        log_info "Found $found_count roles"
    fi

    echo "$roles_json"
}

# Assign roles to service account user
assign_roles() {
    local token=$1
    local user_id=$2
    local client_id=$3
    local roles_json=$4

    log_info "Assigning roles to service account user..."

    # Check if roles_json is empty or contains no roles
    if [ -z "$roles_json" ] || [ "$roles_json" = "[]" ]; then
        log_warn "No roles to assign, skipping"
        return 0
    fi

    log_debug "Roles JSON: $roles_json"

    local assign_response
    local http_code
    http_code=$(curl -k -s -X POST \
        "${KEYCLOAK_URL}/admin/realms/${REALM_NAME}/users/${user_id}/role-mappings/clients/${client_id}" \
        -H "Authorization: Bearer ${token}" \
        -H "Content-Type: application/json" \
        -d "$roles_json" \
        --connect-timeout 10 \
        --max-time 30 \
        -w "%{http_code}" \
        -o /tmp/assign_response_body.txt 2>&1) || true

    assign_response=$(cat /tmp/assign_response_body_body.txt 2>/dev/null || echo "")

    log_info "HTTP response code: $http_code"

    if [ "$http_code" = "204" ] || [ "$http_code" = "200" ] || [ "$http_code" = "201" ]; then
        log_info "Roles assigned successfully!"
        return 0
    else
        log_error "Failed to assign roles (HTTP $http_code)"
        log_error "Response body: $(cat /tmp/assign_response_body.txt 2>/dev/null || echo 'empty')"
        return 1
    fi
}

# Main execution
main() {
    log_info "=========================================="
    log_info "Keycloak Service Account Role Assignment"
    log_info "=========================================="
    log_info "Keycloak URL: ${KEYCLOAK_URL}"
    log_info "Realm: ${REALM_NAME}"
    log_info "Service Account Client ID: ${SERVICE_ACCOUNT_CLIENT_ID}"
    log_info "ONCE_ONLY: ${ONCE_ONLY}"
    log_info "=========================================="

    # Wait for Keycloak
    if ! wait_for_keycloak; then
        log_error "Failed to connect to Keycloak, exiting"
        exit 1
    fi

    # Get admin token
    ADMIN_TOKEN=""
    ADMIN_TOKEN=$(get_admin_token)
    if [ -z "$ADMIN_TOKEN" ]; then
        log_error "Failed to get admin token, exiting"
        exit 1
    fi
    log_info "Admin token obtained successfully"

    # Get service account user ID
    log_info "Looking up service account user..."
    SERVICE_ACCOUNT_USER_ID=""
    SERVICE_ACCOUNT_USER_ID=$(get_service_account_user_id "$ADMIN_TOKEN")
    local get_user_exit=$?
    log_debug "get_service_account_user_id returned exit code: $get_user_exit"

    if [ $get_user_exit -ne 0 ] || [ -z "$SERVICE_ACCOUNT_USER_ID" ]; then
        log_error "Failed to get service account user ID (exit code: $get_user_exit)"
        log_error ""
        log_error "TROUBLESHOOTING:"
        log_error "1. Check if the client '${SERVICE_ACCOUNT_CLIENT_ID}' exists in realm '${REALM_NAME}'"
        log_error "2. Check if 'Service Accounts Enabled' is ON for this client"
        log_error "3. Verify the client has proper service account configuration"
        exit 1
    fi
    log_info "Service account user ID: ${SERVICE_ACCOUNT_USER_ID}"

    # Get realm-management client ID
    REALM_MANAGEMENT_CLIENT_ID=""
    REALM_MANAGEMENT_CLIENT_ID=$(get_client_id "$ADMIN_TOKEN" "realm-management")
    if [ -z "$REALM_MANAGEMENT_CLIENT_ID" ]; then
        log_error "Failed to get realm-management client ID, exiting"
        exit 1
    fi
    log_info "realm-management client ID: ${REALM_MANAGEMENT_CLIENT_ID}"

    # Define realm-management roles to assign
    REALM_MANAGEMENT_ROLES="query-users view-users manage-users query-groups view-groups query-clients view-clients"
    log_info "Preparing to assign realm-management roles:"
    log_info "  $REALM_MANAGEMENT_ROLES"

    # Get role representations
    log_info "Fetching role representations..."
    ROLES_JSON=""
    ROLES_JSON=$(get_role_representations "$ADMIN_TOKEN" "$REALM_MANAGEMENT_CLIENT_ID" $REALM_MANAGEMENT_ROLES)

    # Assign roles
    if ! assign_roles "$ADMIN_TOKEN" "$SERVICE_ACCOUNT_USER_ID" "$REALM_MANAGEMENT_CLIENT_ID" "$ROLES_JSON"; then
        log_error "Failed to assign realm-management roles"
        exit 1
    fi

    # Also assign offline_access realm role
    log_info "Assigning offline_access realm role..."
    REALM_CLIENT_ID=""
    REALM_CLIENT_ID=$(get_client_id "$ADMIN_TOKEN" "realm")
    if [ -n "$REALM_CLIENT_ID" ]; then
        OFFLINE_ROLE_JSON=""
        OFFLINE_ROLE_JSON=$(get_role_representations "$ADMIN_TOKEN" "$REALM_CLIENT_ID" "offline_access")
        if ! assign_roles "$ADMIN_TOKEN" "$SERVICE_ACCOUNT_USER_ID" "$REALM_CLIENT_ID" "$OFFLINE_ROLE_JSON"; then
            log_warn "Failed to assign offline_access role (non-critical)"
        fi
    else
        log_warn "Could not find realm client, skipping offline_access role"
    fi

    log_info "=========================================="
    log_info "Role assignment completed successfully!"
    log_info "=========================================="

    # Exit if ONCE_ONLY is true
    if [ "$ONCE_ONLY" = "true" ]; then
        log_info "Exiting (ONCE_ONLY=true)"
        exit 0
    fi

    # Keep running if ONCE_ONLY is false (for sidecar mode)
    log_info "Keeping container running (ONCE_ONLY=false)"
    sleep infinity
}

# Run main function
main "$@"
