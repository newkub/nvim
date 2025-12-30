import { useConfigEditorStore } from "~/stores/config-editor";

export function useConfigEditor() {
	const store = useConfigEditorStore();
	return store;
}
