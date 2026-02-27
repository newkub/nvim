import { WriteConfigBodySchema } from "#shared/types/config";
import { writeConfigFileById } from "../../utils/config-files";

export default defineEventHandler(async (event) => {
	const body = WriteConfigBodySchema.parse(await readBody(event));
	await writeConfigFileById(body.id, body.content);
	return { ok: true };
});
