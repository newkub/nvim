import { readFile, writeFile } from "node:fs/promises";

import { configAllowlistById } from "./config-allowlist";
import { resolveInRepo } from "./repo-path";

export async function readConfigFileById(id: string): Promise<string> {
	const item = configAllowlistById.get(id);
	if (!item) {
		throw createError({ statusCode: 404, statusMessage: "Unknown config id" });
	}
	return readFile(resolveInRepo(item.relPath), "utf8");
}

export async function writeConfigFileById(
	id: string,
	content: string,
): Promise<void> {
	const item = configAllowlistById.get(id);
	if (!item) {
		throw createError({ statusCode: 404, statusMessage: "Unknown config id" });
	}
	await writeFile(resolveInRepo(item.relPath), content, "utf8");
}
