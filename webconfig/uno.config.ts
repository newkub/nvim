import { defineConfig, presetIcons, presetTypography, presetWind4 } from "unocss";

export default defineConfig({
	presets: [presetWind4(), presetTypography(), presetIcons()],
});
