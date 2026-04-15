#!/bin/bash
set -e

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

nvm install 20
nvm use 20

cd ~/ci-cd

git pull origin main
npm install
npm run build

# 🔥 Kill old app
fuser -k 3000/tcp || true

# Start new app
nohup npm start > app.log 2>&1 &