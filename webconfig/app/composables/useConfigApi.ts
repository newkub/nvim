import type { ConfigFile } from "~/shared/types/config";

export function useConfigApi() {
	async function listFiles() {
		return $fetch<ConfigFile[]>("/api/config/list");
	}

	async function readFileById(id: string) {
		return $fetch<{ id: string; content: string }>("/api/config/file", {
			query: { id },
		});
	}

	async function writeFileById(id: string, content: string) {
		return $fetch<{ ok: true }>("/api/config/file", {
			method: "PUT",
			body: { id, content },
		});
	}

	return { listFiles, readFileById, writeFileById };
}
