import { eq, sql } from "drizzle-orm/sql";
import drizzleDatabase from "../drizzle_mysql/database"
import { activities } from "../drizzle_mysql/schemas/activity_schema"

const createActivityEntry = async (uuid: string): Promise<string> => {
    await drizzleDatabase.insert(activities).values({
        user: uuid
    }).onDuplicateKeyUpdate({ set: { user: sql`user` } }).$returningId();
    return uuid;
}

const switchActivityState = async (uuid: string, socket?: string | undefined): Promise<boolean> => {
    let hasSocket = socket !== undefined;
    let res = await drizzleDatabase.update(activities)
        .set({ isActive: hasSocket, ...(hasSocket ? { socket: socket } : { socket: null }) })
        .where(eq(activities.user, uuid));
    return res.length > 0;
}


export { createActivityEntry, switchActivityState }