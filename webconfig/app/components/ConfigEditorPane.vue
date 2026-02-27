<script setup lang="ts">
import type { ConfigFile } from "~/shared/types/config";
import type { EditorStatus } from "~/types/config-editor";

defineProps<{
	selected?: ConfigFile;
	status: EditorStatus;
	errorMessage: string;
	modelValue: string;
}>();

defineEmits<(e: "update:modelValue", value: string) => void>();
</script>

<template>
	<main class="rounded-xl border border-zinc-600/50 bg-zinc-800/40 p-3">
		<div class="min-w-0">
			<div class="truncate text-sm font-medium">
				{{ selected?.relPath || '—' }}
			</div>
			<div class="text-xs text-zinc-300">
				<span v-if="status === 'loading'">Loading…</span>
				<span v-else-if="status === 'saving'">Saving…</span>
				<span v-else-if="status === 'saved'">Saved</span>
				<span v-else-if="status === 'error'">Error: {{ errorMessage }}</span>
				<span v-else>Ready</span>
			</div>
		</div>

		<textarea
			:value="modelValue"
			@input="$emit('update:modelValue', ($event.target as HTMLTextAreaElement).value)"
			class="mt-3 h-[70vh] w-full resize-none rounded-lg border border-zinc-600/50 bg-zinc-900/40 p-3 font-mono text-xs leading-relaxed text-zinc-100 outline-none focus:border-blue-600"
			spellcheck="false"
		></textarea>
	</main>
</template>
