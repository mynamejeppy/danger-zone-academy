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
  sed -n '1,/^<div class="wrap">$/p' "$SRC" | sed '$d'
  printf '</head>\n<body>\n'
  sed -n '/^<div class="wrap">$/,$p' "$SRC"
  printf '</body>\n</html>\n'
} > index.html
echo "Built index.html"
