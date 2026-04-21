#!/bin/bash
# ============================================
# Deploy: Astro build → FTP/SSH upload
# Użycie: npm run deploy  (lub bash scripts/deploy.sh)
# ============================================
set -euo pipefail

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

echo "=== [1/3] Building Astro site..."
npm run build

echo "=== [2/3] Uploading to server..."

if [ -n "${SSH_USER:-}" ] && [ -n "${SSH_HOST:-}" ] && [ -n "${SSH_PATH:-}" ]; then
  echo "Using rsync (SSH)..."
  rsync -avz --delete \
    dist/ \
    "${SSH_USER}@${SSH_HOST}:${SSH_PATH}"
elif [ -n "${FTP_HOST:-}" ] && [ -n "${FTP_USER:-}" ] && [ -n "${FTP_PASS:-}" ]; then
  echo "Using lftp (FTP)..."
  lftp -e "
    set ssl:verify-certificate no;
    mirror --reverse --delete --verbose \
      dist/ /public_html/;
    quit
  " -u "${FTP_USER},${FTP_PASS}" "${FTP_HOST}"
else
  echo "ERROR: No deploy credentials configured."
  echo "Set SSH_USER/SSH_HOST/SSH_PATH or FTP_HOST/FTP_USER/FTP_PASS in .env"
  exit 1
fi

echo "=== [3/3] Done!"
echo "Deployed at: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Site: https://www.konferencja-tlumaczy.pl"
