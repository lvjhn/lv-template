#!/usr/bin/env bash
set -euo pipefail

# --- target values
OLD_VALUE="khlv-app"
NEW_VALUE="$1"

# --- replace in root .env
echo ":: Working on .env"
sed -i "s/${OLD_VALUE}/${NEW_VALUE}/g" .env

# --- replace in all files under .helm
echo ":: Working under .helm/ directory."
find .helm -type f -exec sed -i "s/${OLD_VALUE}/${NEW_VALUE}/g" {} +

# --- replace in backend/.env
echo ":: Working on backend/.env." 
sed -i "s/${OLD_VALUE}/${NEW_VALUE}/g" source/backend/.env

