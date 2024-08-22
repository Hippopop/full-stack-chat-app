import { and, eq, or } from "drizzle-orm";
import drizzleDatabase from "../drizzle_mysql/database";
import { DB_Media, DB_Media_Type, DBN_Media, medias } from "../drizzle_mysql/schemas/media_schema";

const insertMediaEntry = async (data: DBN_Media): Promise<DBN_Media> => {
    const entry = await drizzleDatabase.insert(medias).values(data).$returningId();
    return { ...data, key: entry[0]!.key };
};

const getMediaEntry = async (
    uuid: string,
    name: string,
    type: DB_Media_Type,
): Promise<DB_Media | undefined> => {
    const result = await drizzleDatabase.select().from(medias).where(and(eq(medias.uuid, uuid), eq(medias.type, type), eq(medias.name, name),));
    if (result.length === 0 || !result.at(0)) return undefined;
    const element = result.at(0)!;
    return {
        key: element.key,
        name: element.name,
        uuid: element.uuid,
        type: element.type,
        message: element.message,
        extension: element.extension,
    };
};

export { insertMediaEntry, getMediaEntry };
