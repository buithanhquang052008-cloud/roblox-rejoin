#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "== Roblox Rejoin Loader (FINAL) =="

REPO_URL="https://github.com/buithanhquang052008-cloud/roblox-rejoin"
BASE="$HOME/roblox-rejoin"

NODE_DIR="$HOME/.node"
NODE_BIN="$NODE_DIR/bin/node"

BIN_DIR="$HOME/.local/bin"
REJOIN_CMD="$BIN_DIR/rejoin"

# ===============================
# 0. Tạo thư mục cần thiết
# ===============================
mkdir -p "$BIN_DIR"

# ===============================
# 1. Clone / Update repo
# ===============================
if [ ! -d "$BASE/.git" ]; then
  echo "📥 Clone repo..."
  git clone "$REPO_URL" "$BASE"
else
  echo "🔄 Update repo..."
  cd "$BASE"
  git reset --hard
  git pull
fi

# ===============================
# 2. Cài Node.js Android (Termux)
# ===============================
if [ ! -x "$NODE_BIN" ]; then
  echo "📦 Tải Node.js (Android – Termux)..."
  mkdir -p "$NODE_DIR"
  cd "$NODE_DIR"

  ARCH=$(uname -m)
  case "$ARCH" in
    aarch64)
      NODE_URL="https://github.com/termux/termux-packages/releases/download/nodejs-20.11.1/nodejs-v20.11.1-android-aarch64.tar.xz"
      ;;
    armv7l)
      NODE_URL="https://github.com/termux/termux-packages/releases/download/nodejs-20.11.1/nodejs-v20.11.1-android-arm.tar.xz"
      ;;
    *)
      echo "❌ Kiến trúc không hỗ trợ: $ARCH"
      exit 1
      ;;
  esac

  curl -fL "$NODE_URL" -o node.tar.xz
  tar -xf node.tar.xz
  rm node.tar.xz
fi

export PATH="$NODE_DIR/bin:$PATH"

# ===============================
# 3. npm install nếu thiếu
# ===============================
cd "$BASE"
if [ ! -d node_modules ]; then
  echo "📦 npm install..."
  "$NODE_BIN" "$NODE_DIR/lib/node_modules/npm/bin/npm-cli.js" install
fi

# ===============================
# 4. Tạo command `rejoin`
# ===============================
cat > "$REJOIN_CMD" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
cd "$BASE"
"$NODE_BIN" rejoin.cjs </dev/tty
EOF

chmod +x "$REJOIN_CMD"

# add PATH nếu chưa có
if ! echo "\$PATH" | grep -q "$BIN_DIR"; then
  echo "export PATH=\"\$PATH:$BIN_DIR\"" >> ~/.bashrc
fi

echo "================================="
echo "✅ CÀI ĐẶT HOÀN TẤT"
echo "👉 Thoát Termux, mở lại"
echo "👉 Gõ: rejoin"
echo "================================="
# ===============================
# 3. Clone / Update repo
# ===============================
if [ ! -d "$BASE/.git" ]; then
  echo "📦 Cloning repo"
  git clone https://github.com/buithanhquang052008-cloud/roblox-rejoin.git "$BASE"
else
  echo "🔄 Updating repo"
  cd "$BASE"
  git pull --ff-only
fi

# ===============================
# 4. npm install
# ===============================
cd "$BASE"
if [ ! -d node_modules ]; then
  echo "📥 Installing dependencies"
  "$NODE_BIN" npm install
fi

# ===============================
# 5. Create rejoin command
# ===============================
mkdir -p "$BIN_DIR"

cat > "$REJOIN_CMD" <<EOF
#!/usr/bin/env bash
bash "$BASE/run.sh"
EOF

chmod +x "$REJOIN_CMD"

# add PATH if missing
if ! echo "\$PATH" | grep -q "$BIN_DIR"; then
  echo "export PATH=\"\$PATH:$BIN_DIR\"" >> ~/.bashrc
fi

echo "✅ Done!"
echo "👉 Gõ: rejoin"
# ===============================
# 3. Clone / Update repo
# ===============================
if [ ! -d "$BASE/.git" ]; then
  echo "📦 Cloning repo"
  git clone https://github.com/buithanhquang052008-cloud/roblox-rejoin.git "$BASE"
else
  echo "🔄 Updating repo"
  cd "$BASE"
  git pull --ff-only
fi

# ===============================
# 4. npm install (if needed)
# ===============================
cd "$BASE"
if [ ! -d node_modules ]; then
  echo "📥 Installing dependencies"
  "$NODE_BIN" npm install
fi

echo "✅ Loader done"
echo "👉 Run tool with:"
echo "   bash $BASE/run.sh"
