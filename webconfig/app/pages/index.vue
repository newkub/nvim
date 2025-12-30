<script setup lang="ts">
import { useConfigEditor } from "~/composables/facade/useConfigEditor";
import { getConfigGroupByRelPath } from "~/composables/domain/config-groups";
import { ref, computed, onMounted } from "vue";

const editor = useConfigEditor();

type TabKey = "mappings" | "plugins" | "commands";

const activeTab = ref<TabKey>("mappings");

const groups = computed(() => {
	const out: Record<TabKey, typeof editor.files> = {
		mappings: [],
		plugins: [],
		commands: [],
	};

	for (const f of editor.files) {
		const key = getConfigGroupByRelPath(f.relPath);
		if (!key) continue;
		out[key].push(f);
	}
	return out;
});

onMounted(async () => {
	if (editor.files.length === 0) {
		await editor.refreshFiles();
	}
});
</script>

<template>
	<div class="mx-auto max-w-6xl px-4 py-6">
		<header class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
			<div>
				<h1 class="text-xl font-semibold">Neovim Web Config</h1>
				<p class="text-sm text-zinc-300">Edit config by group in one place</p>
			</div>
			<div class="flex items-center gap-2">
				<button
					type="button"
					class="rounded-md bg-zinc-700/60 px-3 py-2 text-sm text-zinc-100 hover:bg-zinc-700"
					@click="editor.refreshFiles()"
				>
					Refresh
				</button>
				<button
					type="button"
					class="rounded-md bg-blue-600 px-3 py-2 text-sm font-medium text-white hover:bg-blue-500 disabled:opacity-50"
					:disabled="editor.status === 'saving' || !editor.selectedId"
					@click="editor.save()"
				>
					Save
				</button>
			</div>
		</header>

		<div class="mt-6 rounded-xl border border-zinc-600/50 bg-zinc-800/40 p-2">
			<div class="grid grid-cols-3 gap-2">
				<button
					type="button"
					class="rounded-lg px-3 py-2 text-left hover:bg-zinc-700/30"
					:class="activeTab === 'mappings' ? 'bg-zinc-700/40 text-white' : 'text-zinc-200'"
					@click="activeTab = 'mappings'"
				>
					<div class="text-sm font-medium">Mappings</div>
					<div class="text-xs text-zinc-400">{{ groups.mappings.length }} files</div>
				</button>
				<button
					type="button"
					class="rounded-lg px-3 py-2 text-left hover:bg-zinc-700/30"
					:class="activeTab === 'plugins' ? 'bg-zinc-700/40 text-white' : 'text-zinc-200'"
					@click="activeTab = 'plugins'"
				>
					<div class="text-sm font-medium">Plugins</div>
					<div class="text-xs text-zinc-400">{{ groups.plugins.length }} files</div>
				</button>
				<button
					type="button"
					class="rounded-lg px-3 py-2 text-left hover:bg-zinc-700/30"
					:class="activeTab === 'commands' ? 'bg-zinc-700/40 text-white' : 'text-zinc-200'"
					@click="activeTab = 'commands'"
				>
					<div class="text-sm font-medium">Commands</div>
					<div class="text-xs text-zinc-400">{{ groups.commands.length }} files</div>
				</button>
			</div>
		</div>

		<div class="mt-6">
			<ConfigGroupPanel :group="activeTab" />
		</div>
	</div>
</template>
