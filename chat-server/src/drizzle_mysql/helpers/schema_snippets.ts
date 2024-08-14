import { sql } from "drizzle-orm";
import { timestamp } from "drizzle-orm/mysql-core";

export const drizzleTimeFields = {
    createdAt: timestamp('created_at').defaultNow(),
    updatedAt: timestamp('updated_at').default(sql`CURRENT_TIMESTAMP(3) on update CURRENT_TIMESTAMP(3)`),
};
