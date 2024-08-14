import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { int, json, mysqlTable, text, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema_snippets";

export const authentication = mysqlTable('authentication', {
    key: int("key").autoincrement().primaryKey(),
    password: text('password').notNull(),
    phone: varchar('phone', { length: 256 }).unique(),
    uuid: varchar('uuid', { length: 256, }).notNull().unique(),
    email: varchar("email", { length: 256 }).notNull().unique(),
    tokens: json('tokens').$type<string[]>().notNull().default([]),
    ...drizzleTimeFields,
});


export const DB_Authentication_Schema = createSelectSchema(authentication, {
    phone: (schema) => schema.phone.optional(),
    createdAt: (schema) => schema.createdAt.optional(),
    updatedAt: (schema) => schema.updatedAt.optional(),
});
export const DBN_Authentication_Schema = createInsertSchema(authentication);

export type DB_Authentication = z.infer<typeof DB_Authentication_Schema>;
export type DBN_Authentication = z.infer<typeof DBN_Authentication_Schema>;

export default {
    authentication,
    DB_Authentication_Schema,
    DBN_Authentication_Schema,
}