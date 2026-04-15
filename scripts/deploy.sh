#!/bin/bash
set -e

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

nvm use 20

echo "🚀 Starting deployment..."

cd ~/ci-cd

echo "📥 Pull latest code"
git pull origin main

echo "📦 Install dependencies"
npm install

echo "🏗️ Build project"
npm run build

echo "🔄 Restart app with PM2"
pm2 restart next-app || pm2 start npm --name "next-app" -- start

echo "💾 Save PM2 process"
pm2 save

echo "✅ Deployment completed!"