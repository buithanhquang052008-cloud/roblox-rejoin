#!/bin/bash

REPO_URL="https://github.com/buithanhquang052008-cloud/roblox-rejoin"
REPO_DIR="$HOME/roblox-rejoin"
BIN_PATH="/data/data/com.termux/files/usr/bin/loader"

# Tạo lệnh loader
if [ ! -f "$BIN_PATH" ]; then
  echo "[+] Tạo lệnh loader..."
  cp "$0" "$BIN_PATH" && chmod +x "$BIN_PATH"
  echo "[✓] Gõ 'loader' để chạy lần sau"
fi

# Cài git
if ! command -v git >/dev/null; then
  echo "[+] Cài git..."
  pkg update -y && pkg install git -y || exit 1
fi

# Clone hoặc pull repo
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "[+] Clone repo..."
  git clone "$REPO_URL" "$REPO_DIR" || exit 1
else
  echo "[+] Update repo..."
  cd "$REPO_DIR" || exit 1
  git reset --hard
  git pull
fi

cd "$REPO_DIR" || exit 1

# Cài Node.js
if ! command -v node >/dev/null; then
  echo "[+] Cài Node.js..."
  pkg install nodejs -y || exit 1
fi

# Cài thư viện
if [ ! -d node_modules ]; then
  echo "[+] npm install..."
  npm install || exit 1
fi

# Chạy tool
echo "[✓] Chạy Roblox Rejoin Tool"
node rejoin.cjs
