import { configAllowlist } from "../../utils/config-allowlist";

export default defineEventHandler(() => {
	return configAllowlist;
});
