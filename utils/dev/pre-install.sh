#!/bin/bash 
source .env

# --- create namespace for development 
echo ":: Creating namespace for development environment."
kubectl create namespace dev-$PROJECT_NAME

# --- create namespace for production 
echo ":: Creating namespace for production environment." 
kubectl create namespace prod-$PROJECT_NAME

