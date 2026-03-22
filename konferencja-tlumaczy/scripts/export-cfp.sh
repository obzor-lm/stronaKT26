#!/bin/bash
# ============================================
# Export CFP proposals from Google Sheets → JSON
# Wymaga: gcloud CLI z service account lub curl + API key
# Użycie: bash scripts/export-cfp.sh
# ============================================
set -euo pipefail

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

OUTPUT_FILE="src/data/cfp-proposals.json"
SHEET_NAME="CFP"  # nazwa arkusza w Google Sheets

echo "=== Pobieranie danych CFP z Google Sheets..."

# Opcja A: Google Sheets API v4 z API key (publiczny arkusz)
# curl -s "https://sheets.googleapis.com/v4/spreadsheets/${GOOGLE_SHEETS_ID}/values/${SHEET_NAME}?key=${GOOGLE_API_KEY}" \
#   | node scripts/transform-cfp.js > "${OUTPUT_FILE}"

# Opcja B: Eksport jako CSV → konwersja do JSON
# curl -sL "https://docs.google.com/spreadsheets/d/${GOOGLE_SHEETS_ID}/gviz/tq?tqx=out:csv&sheet=${SHEET_NAME}" \
#   | node scripts/transform-cfp.js > "${OUTPUT_FILE}"

# Opcja C: n8n webhook trigger (najbardziej elastyczna)
# curl -s "${N8N_WEBHOOK_EXPORT_CFP}" > "${OUTPUT_FILE}"

echo "=== Zapisano do ${OUTPUT_FILE}"
echo "=== Wpisy: $(cat ${OUTPUT_FILE} | node -e 'process.stdin.setEncoding("utf8");let d="";process.stdin.on("data",c=>d+=c);process.stdin.on("end",()=>console.log(JSON.parse(d).length))')"
echo ""
echo "Następny krok: npm run build && npm run deploy"
