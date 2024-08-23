import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { boolean, date, int, mysqlEnum, mysqlTable, text, unique, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema_snippets";
import { authentication } from "./auth_schema";

export const activities = mysqlTable('activities', {
    user: varchar('user', { length: 256 }).notNull().unique().references(() => authentication.uuid),
    isActive: boolean('is_active').notNull().default(false),
    ...drizzleTimeFields,
});

export const DB_Activity_Schema = createSelectSchema(activities, {
    createdAt: (schema) => schema.createdAt.optional(),
});

export const DBN_Activity_Schema = createInsertSchema(activities);

export type DB_Activity = z.infer<typeof DB_Activity_Schema>;
export type DBN_Activity = z.infer<typeof DBN_Activity_Schema>;


export default {
    activities,
    DB_Activity_Schema,
    DBN_Activity_Schema,
}