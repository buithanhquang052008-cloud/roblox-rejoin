curl -fsSL https://raw.githubusercontent.com/buithanhquang052008-cloud/roblox-rejoin/main/loader.sh | bash
  # Node 18 LTS – chạy ổn Android 10
  curl -L https://unofficial-builds.nodejs.org/download/release/v18.19.1/node-v18.19.1-linux-arm64.tar.gz -o node.tar.gz \
  || curl -L https://unofficial-builds.nodejs.org/download/release/v18.19.1/node-v18.19.1-linux-armv7l.tar.gz -o node.tar.gz

  tar -xzf node.tar.gz --strip-components=1
  rm node.tar.gz
fi

# 4. Export PATH
export PATH="$NODE_DIR/bin:$PATH"

# 5. Kiểm tra node
echo -n "→ Node version: "
node -v || { echo "❌ Node lỗi"; exit 1; }

# 6. Cài node_modules nếu cần
cd "$REPO_DIR"
if [ ! -d node_modules ]; then
  echo "→ npm install (local)"
  npm install --no-audit --no-fund
fi

# 7. Chạy tool
echo "→ Chạy rejoin.cjs"
node rejoin.cjs
