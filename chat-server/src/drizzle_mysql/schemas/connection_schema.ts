import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { date, int, mysqlEnum, mysqlTable, text, unique, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema_snippets";
import { authentication } from "./auth_schema";
import { messages } from "./message_schema";

export const connections = mysqlTable('connections', {
    key: int("key").autoincrement().primaryKey(),
    userOne: varchar('user_one', { length: 256 }).notNull().references(() => authentication.uuid),
    userTwo: varchar('user_two', { length: 256 }).notNull().references(() => authentication.uuid),
    lastMessage: varchar('last_message', { length: 256 }).unique().references(() => messages.key),
    ...drizzleTimeFields,
}, (table) => ({
    uniqueItem: unique().on(table.userOne, table.userTwo),
    uniqueName: unique("unique_combination").on(table.userOne, table.userTwo),
}));

export const DB_Connection_Schema = createSelectSchema(connections, {
    createdAt: (schema) => schema.createdAt.optional(),
    updatedAt: (schema) => schema.updatedAt.optional(),
});

export const DBN_Connection_Schema = createInsertSchema(connections);

export type DB_Connection = z.infer<typeof DB_Connection_Schema>;
export type DBN_Connection = z.infer<typeof DBN_Connection_Schema>;


export default {
    connections,
    DB_Connection_Schema,
    DBN_Connection_Schema,
}