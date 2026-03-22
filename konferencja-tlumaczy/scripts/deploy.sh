#!/bin/bash
# ============================================
# Deploy: Astro build → FTP/SSH upload
# Użycie: npm run deploy  (lub bash scripts/deploy.sh)
# ============================================
set -euo pipefail

# Załaduj zmienne środowiskowe
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

echo "=== [1/3] Building Astro site..."
npm run build

echo "=== [2/3] Uploading to server..."

# --- Opcja A: lftp (FTP) ---
# Odkomentuj i dostosuj ścieżkę zdalną:
# lftp -e "
#   set ssl:verify-certificate no;
#   mirror --reverse --delete --verbose \
#     dist/ /public_html/konferencja/;
#   quit
# " -u "${FTP_USER},${FTP_PASS}" "${FTP_HOST}"

# --- Opcja B: rsync (SSH) — szybsza, preferowana ---
# Odkomentuj i dostosuj:
# rsync -avz --delete \
#   dist/ \
#   "${SSH_USER}@${SSH_HOST}:${SSH_PATH}"

echo "=== [3/3] Done!"
echo "Deployed at: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Site: https://www.konferencja-tlumaczy.pl"
