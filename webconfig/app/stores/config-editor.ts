import type { ConfigFile } from "~/shared/types/config";

import type { EditorStatus } from "~/types/config-editor";
import { useConfigApi } from "~/composables/useConfigApi";

export const useConfigEditorStore = defineStore("configEditor", () => {
	const files = ref<ConfigFile[]>([]);
	const selectedId = ref<string>("");
	const content = ref<string>("");
	const status = ref<EditorStatus>("idle");
	const errorMessage = ref<string>("");

	const selected = computed(() =>
		files.value.find((f) => f.id === selectedId.value),
	);

	function setError(e: unknown) {
		status.value = "error";
		errorMessage.value = e instanceof Error ? e.message : String(e);
	}

	async function refreshFiles() {
		status.value = "loading";
		errorMessage.value = "";
		try {
			const api = useConfigApi();
			files.value = await api.listFiles();
			if (!selectedId.value && files.value[0])
				selectedId.value = files.value[0].id;
			status.value = "idle";
		} catch (e) {
			setError(e);
		}
	}

	async function loadSelected() {
		if (!selectedId.value) return;
		status.value = "loading";
		errorMessage.value = "";
		try {
			const api = useConfigApi();
			const res = await api.readFileById(selectedId.value);
			content.value = res.content;
			status.value = "idle";
		} catch (e) {
			setError(e);
		}
	}

	async function save() {
		if (!selectedId.value) return;
		status.value = "saving";
		errorMessage.value = "";
		try {
			const api = useConfigApi();
			await api.writeFileById(selectedId.value, content.value);
			status.value = "saved";
			setTimeout(() => {
				if (status.value === "saved") status.value = "idle";
			}, 800);
		} catch (e) {
			setError(e);
		}
	}

	watch(selectedId, async () => {
		await loadSelected();
	});

	return {
		files,
		selectedId,
		selected,
		content,
		status,
		errorMessage,
		save,
		reload: loadSelected,
		refreshFiles,
	};
});
