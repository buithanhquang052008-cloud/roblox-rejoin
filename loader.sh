#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_URL="https://github.com/buithanhquang052008-cloud/roblox-rejoin.git"
REPO_DIR="$HOME/roblox-rejoin"
BIN_PATH="$PREFIX/bin/loader"

clear
echo "=============================="
echo "  ROBLOX REJOIN LOADER (FIX)  "
echo "=============================="

# ---- TẠO LỆNH loader ----
if [ ! -f "$BIN_PATH" ]; then
  echo "[+] Tạo lệnh loader..."
  cp "$0" "$BIN_PATH"
  chmod +x "$BIN_PATH"
  echo "[✓] Gõ 'loader' để chạy lần sau"
fi

# ---- UPDATE TERMUX ----
echo "[+] Update packages..."
pkg update -y >/dev/null

# ---- CHECK GIT ----
if ! command -v git >/dev/null 2>&1; then
  echo "[+] Cài git..."
  pkg install git -y
fi

# ---- CLONE / UPDATE REPO ----
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

# ---- CHECK NODEJS ----
if ! command -v node >/dev/null 2>&1; then
  echo "[+] Cài NodeJS..."
  pkg install nodejs -y
fi

# ---- CHECK SQLITE ----
if ! command -v sqlite3 >/dev/null 2>&1; then
  echo "[+] Cài sqlite..."
  pkg install sqlite -y
fi

# ---- INSTALL NODE MODULES ----
if [ ! -d "node_modules" ]; then
  echo "[+] npm install..."
  npm install
fi

# ---- CHẠY TOOL ----
echo "[✓] Chạy Roblox Rejoin Tool"
node rejoin.cjs
