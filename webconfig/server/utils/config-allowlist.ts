import { ConfigFileSchema } from "../../shared/types/config";

const ALLOWLIST = [
	{
		id: "actions",
		label: "mappings: actions.lua",
		relPath: "lua/mappings/system/actions.lua",
	},
	{
		id: "editing",
		label: "mappings: editing.lua",
		relPath: "lua/mappings/editing.lua",
	},
	{
		id: "normal_system",
		label: "mappings: normal/system.lua",
		relPath: "lua/mappings/normal/system.lua",
	},
	{
		id: "insert_autocmd",
		label: "autocmds: insert.lua",
		relPath: "lua/core/autocmds/insert.lua",
	},
	{
		id: "snacks_opts",
		label: "snacks: opts.lua",
		relPath: "lua/plugins/ui/snacks/opts.lua",
	},
] as const;

export const configAllowlist = ALLOWLIST.map((f) => ConfigFileSchema.parse(f));

export const configAllowlistById = new Map(
	configAllowlist.map((f) => [f.id, f] as const),
);
