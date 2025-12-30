import { z } from "zod";

export const ConfigFileIdSchema = z.string().min(1);

export const ConfigFileSchema = z.object({
	id: ConfigFileIdSchema,
	label: z.string().min(1),
	relPath: z.string().min(1),
});

export type ConfigFile = z.infer<typeof ConfigFileSchema>;

export const ReadConfigQuerySchema = z.object({
	id: ConfigFileIdSchema,
});

export const WriteConfigBodySchema = z.object({
	id: ConfigFileIdSchema,
	content: z.string(),
});
