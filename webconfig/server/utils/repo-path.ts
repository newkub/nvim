import { resolve } from "node:path";

export function getRepoRootFromWebconfigCwd(): string {
	return resolve(process.cwd(), "..");
}

export function resolveInRepo(relPath: string): string {
	return resolve(getRepoRootFromWebconfigCwd(), relPath);
}
