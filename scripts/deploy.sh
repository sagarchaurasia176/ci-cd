#!/bin/bash
set -e

echo "🚀 Starting deployment..."

# Load NVM properly
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

# Install & use Node 20 (force fix)
nvm install 20
nvm use 20

echo "✅ Node version:"
node -v

# Go to project root
cd ~/ci-cd

# Pull latest code
git pull origin main

# Install dependencies
npm install

# Build project
npm run build

# Start app in background
nohup npm start > app.log 2>&1 &

echo "✅ Deployment completed"