#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_URL="https://github.com/buithanhquang052008-cloud/roblox-rejoin"
REPO_DIR="$HOME/roblox-rejoin"
BIN_PATH="$PREFIX/bin/loader"

echo "[*] Roblox Rejoin Loader (Termux)"

# =========================
# Tạo lệnh loader
# =========================
if [ ! -f "$BIN_PATH" ]; then
  echo "[+] Tạo lệnh loader..."
  cp "$0" "$BIN_PATH"
  chmod +x "$BIN_PATH"
  echo "[✓] Gõ 'loader' để chạy lần sau"
fi

# =========================
# Update + package cơ bản
# =========================
pkg update -y
pkg install -y git nodejs sqlite

# =========================
# FIX LỖI SQLITE3 (CỐT LÕI)
# =========================
# Termux chỉ có 'sqlite', không có 'sqlite3'
if [ ! -f "$PREFIX/bin/sqlite3" ] && [ -f "$PREFIX/bin/sqlite" ]; then
  echo "[+] Fix sqlite3 cho Termux..."
  ln -sf "$PREFIX/bin/sqlite" "$PREFIX/bin/sqlite3"
fi

# =========================
# Clone hoặc update repo
# =========================
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

# =========================
# Cài npm package
# =========================
echo "[+] npm install..."
npm install

# =========================
# Export sqlite bin cho Node
# =========================
export SQLITE_BIN=sqlite3

# =========================
# Chạy tool
# =========================
echo "[✓] Chạy Roblox Rejoin Tool"
node rejoin.cjs
