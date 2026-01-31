#!/bin/bash

REPO_URL="https://github.com/buithanhquang052008-cloud/roblox-rejoin"
REPO_DIR="$HOME/roblox-rejoin"
BIN="$PREFIX/bin/loader"

# Tạo lệnh loader
if [ ! -f "$BIN" ]; then
  cp "$0" "$BIN"
  chmod +x "$BIN"
  echo "✔ Đã tạo lệnh: loader"
fi

pkg install -y git nodejs sqlite coreutils tsu

if [ ! -d "$REPO_DIR/.git" ]; then
  git clone "$REPO_URL" "$REPO_DIR" || exit 1
else
  cd "$REPO_DIR" && git pull
fi

cd "$REPO_DIR" || exit 1
npm install

echo "🔥 Chạy bằng root (tsu)"
tsu node rejoin.cjs
cd "$REPO_DIR"

# 5️⃣ Cài node_modules
if [ ! -d "node_modules" ]; then
  echo "📦 npm install..."
  npm install --no-audit --no-fund
fi

# 6️⃣ Chạy tool (FIX LỖI rejoin.cjsnode)
chmod +x rejoin.cjs
echo "✅ Chạy rejoin.cjs"
node rejoin.cjs
