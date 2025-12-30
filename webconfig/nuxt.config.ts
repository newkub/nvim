// https://nuxt.com/docs/api/configuration/nuxt-config
import { fileURLToPath } from "node:url";
export default defineNuxtConfig({
	compatibilityDate: "2025-12-31",
	devtools: { enabled: true },
	modules: [
		"@nuxtjs/color-mode",
		"@vueuse/nuxt",
		"@unocss/nuxt",
		"@pinia/nuxt",
		"@nuxt/icon",
	],
	alias: {
		"~/shared": fileURLToPath(new URL("./shared", import.meta.url)),
	},
	colorMode: {
		classSuffix: "",
	},
});
