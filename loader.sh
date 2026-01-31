#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_URL="https://github.com/buithanhquang052008-cloud/roblox-rejoin"
REPO_DIR="$HOME/roblox-rejoin"
BIN_PATH="/data/data/com.termux/files/usr/bin/loader"

clear
echo "=============================="
echo "  ROBLOX REJOIN LOADER (FIX)  "
echo "=============================="

# Tạo lệnh loader (chạy bằng chữ 'loader')
if [ ! -f "$BIN_PATH" ]; then
  echo "[+] Tạo lệnh loader..."
  cp "$0" "$BIN_PATH"
  chmod +x "$BIN_PATH"
  echo "[✓] Gõ 'loader' để chạy lần sau"
fi

# Cài git
if ! command -v git >/dev/null 2>&1; then
  echo "[+] Cài git..."
  pkg update -y
  pkg install git -y
fi

# Clone hoặc update repo
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "[+] Clone repo..."
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "[+] Update repo..."
  cd "$REPO_DIR"
  git reset --hard
  git pull
fi

cd "$REPO_DIR"

# Cài Node.js
if ! command -v node >/dev/null 2>&1; then
  echo "[+] Cài Node.js..."
  pkg install nodejs -y
fi

# 🔥 AUTO CÀI SQLITE (FIX LỖI CHÍNH)
if ! command -v sqlite3 >/dev/null 2>&1; then
  echo "[+] Cài sqlite3..."
  pkg install sqlite -y
fi

# Cài node_modules
if [ ! -d node_modules ]; then
  echo "[+] npm install..."
  npm install
fi

# Chạy tool
echo "[✓] Chạy Roblox Rejoin Tool"
node rejoin.cjs
