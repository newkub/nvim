<script setup lang="ts">
const links = [
	{ to: "/", label: "Dashboard" },
	{ to: "/mappings", label: "Mappings" },
	{ to: "/plugins", label: "Plugins" },
	{ to: "/commands", label: "Commands" },
] as const;
</script>

<template>
	<nav class="sticky top-0 z-10 border-b border-zinc-600/50 bg-zinc-900/80 backdrop-blur">
		<div class="mx-auto flex max-w-6xl items-center justify-between gap-4 px-4 py-3">
			<div class="min-w-0">
				<NuxtLink to="/" class="truncate text-sm font-semibold text-zinc-100 hover:text-white">
					Neovim Web Config
				</NuxtLink>
				<div class="mt-0.5 text-xs text-zinc-500">Allowlist-based editor</div>
			</div>

			<div class="flex items-center gap-1">
				<NuxtLink
					v-for="l in links"
					:key="l.to"
					:to="l.to"
					class="rounded-md px-3 py-2 text-sm text-zinc-200 hover:bg-zinc-800/50 hover:text-zinc-50"
					active-class="bg-zinc-800/60 text-white"
					exact-active-class="bg-zinc-800/60 text-white"
				>
					{{ l.label }}
				</NuxtLink>
			</div>
		</div>
	</nav>
</template>
