<script setup lang="ts">
import type { ConfigFile } from "~/shared/types/config";

defineProps<{
	files: ConfigFile[];
	selectedId: string;
}>();

defineEmits<(e: "select", id: string) => void>();
</script>

<template>
	<aside class="rounded-xl border border-zinc-800 bg-zinc-900/50 p-3">
		<div class="text-xs font-medium uppercase tracking-wide text-zinc-400">Files</div>
		<div class="mt-2 flex flex-col gap-1">
			<button
				v-for="f in files"
				:key="f.id"
				class="rounded-md px-3 py-2 text-left text-sm hover:bg-zinc-800"
				:class="f.id === selectedId ? 'bg-zinc-800' : ''"
				@click="$emit('select', f.id)"
			>
				<div class="font-medium">{{ f.label }}</div>
				<div class="text-xs text-zinc-400">{{ f.relPath }}</div>
			</button>
		</div>
	</aside>
</template>
