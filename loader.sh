#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_URL="https://github.com/buithanhquang052008-cloud/roblox-rejoin.git"
REPO_DIR="$HOME/roblox-rejoin"
BIN_PATH="$PREFIX/bin/loader"

clear
echo "=============================="
echo "  ROBLOX REJOIN LOADER (FIX)  "
echo "=============================="

# ---- KIỂM TRA TERMUX ----
if [ -z "$PREFIX" ]; then
  echo "[X] Script này chỉ chạy trên Termux"
  exit 1
fi

# ---- TẠO LỆNH loader ----
if [ ! -f "$BIN_PATH" ]; then
  echo "[+] Tạo lệnh loader..."
  cp "$0" "$BIN_PATH"
  chmod +x "$BIN_PATH"
  echo "[✓] Dùng lệnh: loader"
fi

# ---- UPDATE ----
echo "[+] Update packages..."
pkg update -y >/dev/null

# ---- GIT ----
if ! command -v git >/dev/null 2>&1; then
  echo "[+] Cài git..."
  pkg install git -y
fi

# ---- NODEJS ----
if ! command -v node >/dev/null 2>&1; then
  echo "[+] Cài NodeJS..."
  pkg install nodejs -y
fi

# ---- SQLITE ----
if ! command -v sqlite3 >/dev/null 2>&1; then
  echo "[+] Cài sqlite..."
  pkg install sqlite -y
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

# ---- NPM ----
if [ -f package.json ] && [ ! -d node_modules ]; then
  echo "[+] npm install..."
  npm install
fi

# ---- EXPORT PATH (FIX sqlite3 not found) ----
export PATH="$PREFIX/bin:$PATH"

# ---- CHẠY TOOL ----
echo "[✓] Chạy Roblox Rejoin Tool"
node rejoin.cjs
