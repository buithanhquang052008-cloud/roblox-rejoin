#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "🚀 Roblox Rejoin Loader (NO apt / pkg)"

REPO_URL="https://github.com/buithanhquang052008-cloud/roblox-rejoin"
REPO_DIR="$HOME/roblox-rejoin"

### ===== AUTO ARCH =====
ARCH=$(uname -m)
NODE_VERSION="18.19.1"

if [[ "$ARCH" == "aarch64" ]]; then
  NODE_ARCH="linux-arm64"
elif [[ "$ARCH" == "armv7l" ]]; then
  NODE_ARCH="linux-armv7l"
else
  echo "❌ CPU không hỗ trợ: $ARCH"
  exit 1
fi

### ===== NODE PATH =====
NODE_DIR="$HOME/.node"
NODE_BIN="$NODE_DIR/bin/node"
NPM_BIN="$NODE_DIR/bin/npm"

### ===== DOWNLOAD NODE (NO apt) =====
if [ ! -x "$NODE_BIN" ]; then
  echo "📦 Tải Node.js $NODE_VERSION ($NODE_ARCH)"
  mkdir -p "$NODE_DIR"
  cd "$NODE_DIR"

  NODE_TAR="node-v$NODE_VERSION-$NODE_ARCH.tar.xz"
  curl -L "https://nodejs.org/dist/v$NODE_VERSION/$NODE_TAR" -o node.tar.xz

  tar -xJf node.tar.xz
  mv node-v$NODE_VERSION-$NODE_ARCH/* "$NODE_DIR/"
  rm -rf node-v$NODE_VERSION-$NODE_ARCH node.tar.xz

  chmod +x "$NODE_BIN" "$NPM_BIN"
fi

export PATH="$NODE_DIR/bin:$PATH"

### ===== CLONE / UPDATE REPO =====
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "📥 Clone repo"
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "🔄 Update repo"
  cd "$REPO_DIR"
  git reset --hard
  git pull
fi

### ===== NPM INSTALL =====
cd "$REPO_DIR"
if [ ! -d "node_modules" ]; then
  echo "📦 npm install"
  "$NPM_BIN" install
fi

### ===== RUN TOOL =====
echo "🎮 Chạy Rejoin Tool"
exec "$NODE_BIN" rejoin.cjs
  mv node-v$NODE_VERSION-linux-arm64/* "$NODE_DIR/"
  rm -rf node-v$NODE_VERSION-linux-arm64

  chmod +x "$NODE_BIN" "$NPM_BIN"
fi

### PATH
export PATH="$NODE_DIR/bin:$PATH"

### CLONE / UPDATE REPO
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "⬇ Clone repo"
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "🔄 Update repo"
  cd "$REPO_DIR"
  git reset --hard
  git pull
fi

### NPM INSTALL
cd "$REPO_DIR"
if [ ! -d node_modules ]; then
  echo "📦 npm install"
  "$NPM_BIN" install
fi

### RUN
echo "🚀 Chạy Rejoin Tool"
"$NODE_BIN" rejoin.cjs
  chmod +x "$NODE_BIN" "$NPM_BIN"
  echo "✔ Node.js đã sẵn sàng"
fi

### EXPORT PATH (không dùng which)
export PATH="$NODE_DIR/bin:$PATH"

### CLONE / UPDATE REPO
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "⬇ Clone repo..."
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "🔄 Update repo..."
  cd "$REPO_DIR"
  git reset --hard
  git pull
fi

### NPM INSTALL
cd "$REPO_DIR"
if [ ! -d "node_modules" ]; then
  echo "📦 npm install..."
  "$NPM_BIN" install
fi

### CHẠY TOOL
echo "🚀 Chạy Rejoin Tool..."
"$NODE_BIN" rejoin.cjs
