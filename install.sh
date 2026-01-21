#!/data/data/com.termux/files/usr/bin/bash

echo "[+] Updating system..."
pkg update -y && pkg upgrade -y

echo "[+] Installing requirements..."
pkg install -y nodejs curl git

echo "[+] Installing roblox-rejoin..."
curl -fsSL https://raw.githubusercontent.com/buithanhquang052008-cloud/roblox-rejoin/main/roblox-rejoin.cjs \
-o $PREFIX/bin/roblox-rejoin

chmod +x $PREFIX/bin/roblox-rejoin

echo "[✓] Done!"
echo "Run: roblox-rejoin"
