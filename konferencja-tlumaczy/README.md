# Konferencja Tłumaczy 2026

Strona internetowa i system marketingowy Konferencji Tłumaczy 2026.

- **Data:** 26 września 2026
- **Miejsce:** Warszawa
- **Strona:** https://www.konferencja-tlumaczy.pl
- **Organizator:** ZZTP

## Stack

- **SSG:** [Astro](https://astro.build/)
- **Backend:** n8n (webhooks)
- **Dane:** Google Sheets
- **Hosting:** własny serwer (FTP/SSH)

## Szybki start

```bash
# Instalacja
npm install

# Dev server (localhost:4321)
npm run dev

# Build
npm run build

# Deploy na serwer
npm run deploy
```

## Struktura

```
src/           → kod strony (Astro pages, components, layouts)
marketing/     → newslettery, szablony grafik, prompty AI
n8n/           → eksporty workflow n8n (backup)
scripts/       → deploy, eksport danych, screenshoty
public/        → assety statyczne (logo, favicon, OG image)
```

## Workflow

1. Edytujesz pliki lokalnie
2. `npm run dev` — podgląd na localhost
3. `git add -A && git commit -m "opis" && git push` — archiwum
4. `npm run deploy` — build + upload na serwer

## Zmienne środowiskowe

Skopiuj `.env.example` do `.env` i uzupełnij dane.
