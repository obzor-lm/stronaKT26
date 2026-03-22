import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://www.konferencja-tlumaczy.pl',
  output: 'static',
  build: {
    assets: '_assets',
  },
  vite: {
    css: {
      preprocessorOptions: {},
    },
  },
});
