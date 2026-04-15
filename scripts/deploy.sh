#!/bin/bash
set -e

echo "🚀 Starting deployment..."

# Load NVM properly
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

# Ensure Node 20 is installed & used
nvm install 20
nvm use 20

echo "✅ Node version:"
node -v

cd ~/ci-cd

echo "🧹 Clean old changes"
git reset --hard
git clean -fd

echo "📥 Pull latest code"
git pull origin main

echo "📦 Install dependencies"
npm install

echo "🏗️ Build project"
npm run build

echo "🔄 Restart app with PM2"

# Delete old process if exists (avoids weird state)
pm2 delete next-app || true

# Start fresh with correct Node env
pm2 start npm --name "next-app" -- start

echo "💾 Save PM2 process"
pm2 save

echo "✅ Deployment completed!"