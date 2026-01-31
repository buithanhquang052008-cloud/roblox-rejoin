#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_URL="https://github.com/buithanhquang052008-cloud/roblox-rejoin"
REPO_DIR="$HOME/roblox-rejoin"
BIN="/data/data/com.termux/files/usr/bin/loader"

echo "🚀 Roblox Rejoin Loader (FINAL)"

# ===== TẠO LỆNH loader =====
if [ ! -f "$BIN" ]; then
  echo "[+] Cài lệnh loader"
  cp "$0" "$BIN"
  chmod +x "$BIN"
  echo "[✓] Gõ 'loader' để chạy lần sau"
fi

# ===== FIX dpkg kẹt =====
dpkg --configure -a >/dev/null 2>&1 || true

# ===== UPDATE + TOOL CƠ BẢN =====
pkg update -y >/dev/null
pkg install -y git nodejs sqlite tsu >/dev/null

# ===== CLONE / UPDATE REPO =====
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "[+] Clone repo"
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "[+] Update repo"
  cd "$REPO_DIR"
  git reset --hard
  git pull
fi

cd "$REPO_DIR"

# ===== CÀI NODE MODULE =====
if [ ! -d node_modules ]; then
  echo "[+] npm install"
  npm install
fi

# ===== CHẠY BẰNG ROOT =====
echo "[✓] Chạy rejoin.cjs (root)"
tsu node rejoin.cjs || node rejoin.cjs
