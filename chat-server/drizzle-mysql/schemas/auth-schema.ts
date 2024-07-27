import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { int, json, mysqlTable, serial, text, timestamp, uniqueIndex, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema-snippets";

export const authentication = mysqlTable('authentication', {
    ...drizzleTimeFields,
    password: text('password').notNull(),
    key: int("key").autoincrement().primaryKey(),
    phone: varchar('phone', { length: 256 }).unique(),
    uuid: varchar('uuid', { length: 256, }).notNull().unique(),
    email: varchar("email", { length: 256 }).notNull().unique(),
    tokens: json('tokens').$type<string[]>().notNull().default([]),
});


export const DB_Authentication_Schema = createSelectSchema(authentication);
export const DBN_Authentication_Schema = createInsertSchema(authentication);

export type DB_Authentication = z.infer<typeof DB_Authentication_Schema>;
export type DBN_Authentication = z.infer<typeof DBN_Authentication_Schema>;