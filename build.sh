#!/bin/sh
# Builds index.html for GitHub Pages from danger-zone-academy.html.
# The Claude artifact version has no <html>/<head> wrapper (Claude adds one),
# so this wraps it: everything above <div class="wrap"> goes in <head>.
set -e
cd "$(dirname "$0")"
SRC=danger-zone-academy.html
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n'
  printf '<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n'
  printf '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px system-ui,sans-serif}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  cat <<'EOF'
<link rel="manifest" href="manifest.webmanifest">
<meta name="theme-color" content="#e9eeed" media="(prefers-color-scheme: light)">
<meta name="theme-color" content="#0e1513" media="(prefers-color-scheme: dark)">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-title" content="DZ Academy">
<meta name="apple-mobile-web-app-status-bar-style" content="default">
<link rel="apple-touch-icon" href="icons/apple-touch-icon.png">
<link rel="icon" type="image/png" href="icons/icon-192.png">
EOF
  sed -n '1,/^<div class="wrap">$/p' "$SRC" | sed '$d'
  printf '</head>\n<body>\n'
  sed -n '/^<div class="wrap">$/,$p' "$SRC"
  cat <<'EOF'
<script>if ("serviceWorker" in navigator) addEventListener("load", () => navigator.serviceWorker.register("sw.js").catch(() => {}));</script>
EOF
  printf '</body>\n</html>\n'
} > index.html
echo "Built index.html"
