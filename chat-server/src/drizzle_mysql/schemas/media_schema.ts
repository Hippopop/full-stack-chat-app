import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { date, int, mysqlEnum, mysqlTable, text, unique, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema_snippets";
import { authentication } from "./auth_schema";
import { messages } from "./message_schema";

export const medias = mysqlTable('medias', {
    key: int("key").autoincrement().primaryKey(),
    name: varchar('name', { length: 256 }).notNull(),
    extension: varchar('extension', { length: 50 }).notNull(),
    message: varchar('message', { length: 256 }).references(() => messages.key),
    type: mysqlEnum('type', ['profile', 'photo', 'video', 'voice_note']).notNull(),
    uuid: varchar('uuid', { length: 256, }).notNull().unique().references(() => authentication.uuid),
    ...drizzleTimeFields,
}, (table) => ({
    uniqueItem: unique().on(table.uuid, table.name, table.type, table.message),
    uniqueName: unique("unique_combination").on(table.uuid, table.name, table.type, table.message),
}));

export const DB_Media_Schema = createSelectSchema(medias, {
    message: (schema) => schema.message.optional(),
    createdAt: (schema) => schema.createdAt.optional(),
    updatedAt: (schema) => schema.updatedAt.optional(),
});

const DB_Media_Type_Schema = DB_Media_Schema.shape.type;
export const DBN_Media_Schema = createInsertSchema(medias);


export type DB_Media = z.infer<typeof DB_Media_Schema>;
export type DBN_Media = z.infer<typeof DBN_Media_Schema>;
export type DB_Media_Type = z.infer<typeof DB_Media_Type_Schema>;


export default {
    medias,
    DB_Media_Schema,
    DBN_Media_Schema,
}