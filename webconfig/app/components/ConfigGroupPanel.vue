<script setup lang="ts">
import type { ConfigFile } from "~/shared/types/config";

import { computed, onMounted, ref, watch } from "vue";
import { useConfigEditor } from "~/composables/facade/useConfigEditor";
import {
	getConfigGroupByRelPath,
	getConfigGroupBucket,
	type ConfigGroupKey,
} from "~/composables/domain/config-groups";

const props = defineProps<{
	group: ConfigGroupKey;
}>();

const editor = useConfigEditor();

const query = ref<string>("");
const activeBucket = ref<string>("");

const groupFiles = computed(() => {
	return editor.files.filter(
		(f) => getConfigGroupByRelPath(f.relPath) === props.group,
	);
});

const bucketCounts = computed(() => {
	const counts = new Map<string, number>();
	for (const f of groupFiles.value) {
		const bucket = getConfigGroupBucket(props.group, f.relPath);
		if (!bucket) continue;
		counts.set(bucket, (counts.get(bucket) ?? 0) + 1);
	}
	return [...counts.entries()]
		.sort((a, b) => b[1] - a[1])
		.map(([key, count]) => ({ key, count }));
});

const bucketFilteredFiles = computed(() => {
	const b = activeBucket.value;
	if (!b) return groupFiles.value;
	return groupFiles.value.filter(
		(f) => getConfigGroupBucket(props.group, f.relPath) === b,
	);
});

const filteredFiles = computed(() => {
	const q = query.value.trim().toLowerCase();
	const items = bucketFilteredFiles.value;
	if (!q) return items;
	return items.filter((f: (typeof items)[number]) => {
		return (
			f.label.toLowerCase().includes(q) ||
			f.relPath.toLowerCase().includes(q) ||
			f.id.toLowerCase().includes(q)
		);
	});
});

const selectedInGroup = computed<ConfigFile | undefined>(() => {
	return groupFiles.value.find((f) => f.id === editor.selectedId);
});

function selectFirstIfNeeded() {
	if (selectedInGroup.value) return;
	const first = groupFiles.value[0];
	if (first) editor.selectedId = first.id;
}

function clearBucket() {
	activeBucket.value = "";
}

watch(
	() => props.group,
	() => {
		query.value = "";
		activeBucket.value = "";
	},
);

watch([activeBucket, query], () => {
	if (filteredFiles.value.some((f) => f.id === editor.selectedId)) return;
	const first = filteredFiles.value[0];
	if (first) editor.selectedId = first.id;
});

onMounted(async () => {
	if (editor.files.length === 0) {
		await editor.refreshFiles();
	}
	selectFirstIfNeeded();
});
</script>

<template>
	<div class="grid gap-4">
		<section class="rounded-xl border border-zinc-600/50 bg-zinc-800/40 p-4">
			<div class="flex flex-col gap-3 md:flex-row md:items-start md:justify-between">
				<div>
					<div class="text-sm font-medium">Overview</div>
					<div class="mt-1 text-sm text-zinc-300">
						{{ groupFiles.length }} files in this group
					</div>
				</div>
				<div class="rounded-lg border border-zinc-600/50 bg-zinc-900/40 px-3 py-2 text-sm text-zinc-200">
					{{ filteredFiles.length }}/{{ groupFiles.length }} shown
				</div>
			</div>

			<div class="mt-4">
				<div class="flex items-center justify-between gap-3">
					<div class="text-xs font-medium uppercase tracking-wide text-zinc-400">Breakdown</div>
					<button
						v-if="activeBucket"
						type="button"
						class="rounded-md bg-zinc-700/60 px-3 py-1.5 text-xs text-zinc-100 hover:bg-zinc-700"
						@click="clearBucket()"
					>
						Clear filter
					</button>
				</div>
				<div class="mt-2 flex flex-wrap gap-2">
					<button
						v-for="b in bucketCounts"
						:key="b.key"
						type="button"
						class="rounded-lg border border-zinc-600/50 bg-zinc-900/40 px-3 py-2 text-left hover:border-zinc-500"
						:class="activeBucket === b.key ? 'border-blue-600/70 bg-blue-950/30' : ''"
						@click="activeBucket = activeBucket === b.key ? '' : b.key"
					>
						<div class="text-sm font-medium text-zinc-100">{{ b.key }}</div>
						<div class="text-xs text-zinc-400">{{ b.count }} files</div>
					</button>
					<div
						v-if="bucketCounts.length === 0"
						class="rounded-lg border border-dashed border-zinc-600/50 bg-zinc-900/30 px-3 py-2 text-sm text-zinc-300"
					>
						No breakdown data.
					</div>
				</div>
			</div>
		</section>

		<div class="grid gap-4 md:grid-cols-[280px_1fr]">
			<aside class="rounded-xl border border-zinc-600/50 bg-zinc-800/40 p-3">
				<div class="flex items-center justify-between gap-3">
					<div class="text-xs font-medium uppercase tracking-wide text-zinc-400">Items</div>
					<div class="text-xs text-zinc-400">{{ filteredFiles.length }}/{{ groupFiles.length }}</div>
				</div>

				<div class="mt-3">
					<input
						v-model="query"
						type="text"
						placeholder="Search…"
						class="w-full rounded-lg border border-zinc-600/50 bg-zinc-900/40 px-3 py-2 text-sm text-zinc-100 outline-none placeholder:text-zinc-400 focus:border-blue-600"
					/>
				</div>

				<div class="mt-3 flex flex-col gap-1">
					<button
						v-for="f in filteredFiles"
						:key="f.id"
						type="button"
						class="rounded-md px-3 py-2 text-left text-sm hover:bg-zinc-700/30"
						:class="f.id === editor.selectedId ? 'bg-zinc-700/40' : ''"
						@click="editor.selectedId = f.id"
					>
						<div class="font-medium">{{ f.label }}</div>
						<div class="text-xs text-zinc-400">{{ f.relPath }}</div>
					</button>

					<div
						v-if="filteredFiles.length === 0"
						class="rounded-md border border-dashed border-zinc-600/50 p-3 text-sm text-zinc-300"
					>
						No items found.
					</div>
				</div>
			</aside>

			<ConfigEditorPane
				:selected="editor.selected"
				:status="editor.status"
				:error-message="editor.errorMessage"
				:model-value="editor.content"
				@update:model-value="(v) => (editor.content = v)"
			/>
		</div>
	</div>
</template>
