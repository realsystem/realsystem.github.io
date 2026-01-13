import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  site: 'https://realsystem.github.io',
  output: 'static',
  outDir: 'dist',
  integrations: [tailwind()]
});
