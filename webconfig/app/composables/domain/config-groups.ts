export type ConfigGroupKey = "mappings" | "plugins" | "commands";

export function getConfigGroupByRelPath(relPath: string): ConfigGroupKey | null {
	if (relPath.startsWith("lua/mappings/")) return "mappings";
	if (relPath.startsWith("lua/plugins/")) return "plugins";
	if (relPath.startsWith("lua/core/commands/") || relPath.startsWith("lua/core/autocmds/"))
		return "commands";
	return null;
}

export function getConfigGroupBucket(
	group: ConfigGroupKey,
	relPath: string,
): string | null {
	const key = getConfigGroupByRelPath(relPath);
	if (key !== group) return null;

	let prefix = "";
	if (group === "mappings") prefix = "lua/mappings/";
	else if (group === "plugins") prefix = "lua/plugins/";
	else prefix = "lua/core/";

	const rest = relPath.startsWith(prefix) ? relPath.slice(prefix.length) : relPath;
	const parts = rest.split("/").filter(Boolean);
	if (parts.length === 0) return "root";

	if (group === "commands") {
		const top = parts[0] ?? "root";
		if (top === "commands" || top === "autocmds") {
			return parts[1] ? `${top}/${parts[1]}` : top;
		}
		return top;
	}

	return parts[0] ?? "root";
}
