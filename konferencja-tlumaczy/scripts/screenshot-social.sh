#!/bin/bash
# ============================================
# Screenshot social media templates → PNG
# Wymaga: npx playwright install chromium (jednorazowo)
# Użycie: bash scripts/screenshot-social.sh
# ============================================
set -euo pipefail

TEMPLATES_DIR="marketing/social/templates"
OUTPUT_DIR="marketing/social/output"

mkdir -p "$OUTPUT_DIR"

echo "=== Generowanie grafik social media..."

# Rozmiary per szablon (szerokość wbudowana w HTML)
declare -A SIZES=(
  ["post-announcement"]="1200x630"
  ["post-speaker"]="1080x1080"
  ["post-countdown"]="1080x1920"
  ["story-template"]="1080x1920"
)

for html_file in "$TEMPLATES_DIR"/*.html; do
  filename=$(basename "$html_file" .html)
  
  # Pomiń szablony zaczynające się od _
  [[ "$filename" == _* ]] && continue
  
  size=${SIZES[$filename]:-"1200x630"}
  width=$(echo "$size" | cut -d'x' -f1)
  height=$(echo "$size" | cut -d'x' -f2)
  
  output_file="$OUTPUT_DIR/${filename}.png"
  
  echo "  → $filename ($size) → $output_file"
  
  npx playwright screenshot \
    --viewport-size="$width,$height" \
    --full-page \
    "file://$(pwd)/$html_file" \
    "$output_file" \
    2>/dev/null || {
      # Fallback: użyj Node.js z Playwright API
      node -e "
        const { chromium } = require('playwright');
        (async () => {
          const browser = await chromium.launch();
          const page = await browser.newPage({ viewport: { width: $width, height: $height } });
          await page.goto('file://$(pwd)/$html_file');
          await page.screenshot({ path: '$output_file', clip: { x: 0, y: 0, width: $width, height: $height } });
          await browser.close();
        })();
      "
    }
done

echo ""
echo "=== Gotowe! Grafiki w: $OUTPUT_DIR/"
ls -la "$OUTPUT_DIR/"
