#!/bin/bash 
source .env

CHART_DIR=./.helm/dev/ 
NAMESPACE=$PROJECT_MODE-$PROJECT_NAME

# --- INSTALL DEPENDENCIES 
echo ":: Updating Helm dependencies."
cd $CHART_DIR
helm dependency update 

# --- INSTALL HELM CHART 
echo ":: Installing Helm chart."
cd -
helm \
  upgrade \
  --install "$PROJECT_NAME" "$CHART_DIR" \
  -n "$NAMESPACE" \
  --create-namespace \
  -f "$CHART_DIR/values.yaml" \
  -f "$CHART_DIR/values-secret.yaml"