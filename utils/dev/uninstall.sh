#!/bin/bash 
source .env

CHART_DIR=./.helm/dev/ 
NAMESPACE=$PROJECT_MODE-$PROJECT_NAME

# --- UNINSTALL HELM CHART --- #
echo "Uninstalling Helm chart in namespace $NAMESPACE..."
helm uninstall "$PROJECT_NAME" "$CHART_DIR" -n "$NAMESPACE" 

# --- DELETE NAMESPACE --- #
echo "Deleting namespace $NAMESPACE..."
helm delete namespace $NAMESPACE