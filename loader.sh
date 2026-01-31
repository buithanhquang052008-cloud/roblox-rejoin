#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "🚀 Roblox Rejoin Loader (Auto Fix)"

# ===== Cập nhật & cài dependency hệ thống =====
pkg update -y
pkg upgrade -y

echo "📦 Cài NodeJS, npm, sqlite..."
pkg install -y nodejs npm sqlite git

# ===== Kiểm tra sqlite3 =====
if ! command -v sqlite3 >/dev/null 2>&1; then
  echo "❌ sqlite3 vẫn chưa có, cài lại..."
  pkg install -y sqlite
fi

# ===== Kiểm tra node =====
if ! command -v node >/dev/null 2>&1; then
  echo "❌ NodeJS chưa cài!"
  exit 1
fi

# ===== Vào thư mục tool =====
TOOL_DIR="$HOME/roblox-rejoin"

if [ ! -d "$TOOL_DIR" ]; then
  echo "📥 Clone repo..."
  git clone https://github.com/buithanhquang052008-cloud/roblox-rejoin.git "$TOOL_DIR"
fi

cd "$TOOL_DIR"

# ===== Cài npm packages =====
echo "📦 Cài npm packages..."
npm install --no-audit --no-fund

# ===== Quyền chạy =====
chmod +x rejoin.cjs

# ===== Chạy tool =====
echo "✅ Setup hoàn tất! Đang chạy tool..."
node rejoin.cjs# =========================
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
