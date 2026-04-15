export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm use 20


cd ci-cd
git pull origin main
npm install
npm run build
npm run dev