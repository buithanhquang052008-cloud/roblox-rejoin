#!/usr/bin/env node
/**
 * Roblox Rejoin Tool – Fixed Version
 */

const fs = require("fs");
const path = require("path");
const { execSync } = require("child_process");
const figlet = require("figlet");
const boxen = require("boxen");

console.log(
  boxen(
    figlet.textSync("ROBLOX", { horizontalLayout: "default" }) +
      "\nRejoin Tool",
    { padding: 1, borderColor: "cyan" }
  )
);

function run(cmd) {
  try {
    return execSync(cmd, { stdio: "pipe" }).toString().trim();
  } catch {
    return null;
  }
}

if (!run("command -v sqlite3")) {
  console.error("❌ sqlite3 chưa được cài. Chạy: pkg install sqlite -y");
  process.exit(1);
}

function getRobloxCookie(pkg) {
  try {
    const tmp = `/sdcard/cookies_temp_${Date.now()}.db`;
    const q = `sqlite3 "${tmp}" "SELECT value FROM cookies WHERE name='ROBLOSECURITY' LIMIT 1;"`;
    const r = run(q);
    if (!r) throw new Error("Không tìm thấy cookie");
    return r;
  } catch (e) {
    console.error(`❌ [${pkg}] ${e.message}`);
    return null;
  }
}

const pkg = "com.roblox.client";
const cookie = getRobloxCookie(pkg);

const dir = path.join(process.env.HOME, "roblox-rejoin");
const file = path.join(dir, "multi_configs.json");
if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });

let data = {};
if (fs.existsSync(file)) {
  try { data = JSON.parse(fs.readFileSync(file)); } catch {}
}

data[pkg] = { cookie, updatedAt: new Date().toISOString() };
fs.writeFileSync(file, JSON.stringify(data, null, 2));
console.log("✅ Setup hoàn tất!");
