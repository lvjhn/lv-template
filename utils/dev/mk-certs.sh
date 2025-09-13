#!/bin/bash
source .env 

# --- set up certificates directory
CERTS_DIR=./.helm/dev/certs/
mkdir -p $CERTS_DIR

# --- create certificate and secret 
function issue_certificate() {
    # --- CREATE CERTIFICATE
    DOMAIN=$1 
    FILE_NAME=$2

    mkcert \
        -cert-file $CERTS_DIR/$FILE_NAME.crt \
        -key-file $CERTS_DIR/$FILE_NAME.key \
        $DOMAIN

    # --- CREATE SECRET 
    SECRET_NAME=$FILE_NAME-tls
    
    # --- delete existing secret
    if kubectl get secret "$SECRET_NAME" -n "$PROJECT_NAME" &>/dev/null; then
        echo ":: Deleting existing secret $SECRET_NAME..."
        kubectl delete secret "$SECRET_NAME" -n "$PROJECT_NAME"
    fi

    echo ":: Creating secret $SECRET_NAME..."
    kubectl \
        create secret tls "$SECRET_NAME" \
        --cert="$CERTS_DIR/$FILE_NAME.crt" \
        --key="$CERTS_DIR/$FILE_NAME.key" \
        -n "$PROJECT_NAME" \
        --dry-run=client -o yaml | kubectl apply -f -
}

issue_certificate api.lv-template.kube backend
issue_certificate lv-template.kube frontend-web
issue_certificate m.lv-template.kube frontend-mobile
issue_certificate lv-template-db database
issue_certificate lv-template-redis redis
issue_certificate pgadmin.lv-template.kube pgadmin
issue_certificate mail.lv-template.kube mail

echo "✅ All certificates generated and TLS secrets applied successfully."
