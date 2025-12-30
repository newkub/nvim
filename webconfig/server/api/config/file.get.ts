import { ReadConfigQuerySchema } from "~/shared/types/config";
import { readConfigFileById } from "../../utils/config-files";

export default defineEventHandler(async (event) => {
	const q = ReadConfigQuerySchema.parse(getQuery(event));
	const content = await readConfigFileById(q.id);
	return { id: q.id, content };
});
