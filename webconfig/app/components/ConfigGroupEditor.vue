<script setup lang="ts">
import { useConfigEditor } from "~/composables/facade/useConfigEditor";
import type { ConfigGroupKey } from "~/composables/domain/config-groups";

const props = defineProps<{
	group: ConfigGroupKey;
	title: string;
	description: string;
}>();

const editor = useConfigEditor();
</script>

<template>
	<div class="mx-auto max-w-6xl px-4 py-6">
			<header class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
				<div>
					<div class="text-sm font-medium text-zinc-200">{{ title }}</div>
					<h1 class="mt-2 text-xl font-semibold">{{ title }}</h1>
					<p class="text-sm text-zinc-400">{{ description }}</p>
				</div>

				<div class="flex items-center gap-2">
					<button
						type="button"
						class="rounded-md bg-zinc-800 px-3 py-2 text-sm hover:bg-zinc-700"
						@click="editor.refreshFiles()"
					>
						Refresh
					</button>
					<button
						type="button"
						class="rounded-md bg-blue-600 px-3 py-2 text-sm font-medium hover:bg-blue-500 disabled:opacity-50"
						:disabled="editor.status === 'saving' || !editor.selectedId"
						@click="editor.save()"
					>
						Save
					</button>
				</div>
			</header>

			<div class="mt-6">
				<ConfigGroupPanel :group="props.group" />
			</div>
	</div>
</template>
