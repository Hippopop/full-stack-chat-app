import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { date, int, mysqlEnum, mysqlTable, text, timestamp, unique, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema_snippets";
import { authentication } from "./auth_schema";
import { messages } from "./message_schema";
import { sql } from "drizzle-orm";

export const connections = mysqlTable('connections', {
    key: int("key").autoincrement().primaryKey(),
    acceptTimestamp: int('accept_timestamp'),
    toUser: varchar('to_user', { length: 256 }).notNull().references(() => authentication.uuid),
    fromUser: varchar('from_user', { length: 256 }).notNull().references(() => authentication.uuid),
    connectionStatus: mysqlEnum('connection_status', ['requested', 'accepted', 'rejected', 'blocked']),
    lastMessage: varchar('last_message', { length: 256 }).unique().references(() => messages.key),
    ...drizzleTimeFields,
}, (table) => ({
    uniqueItem: unique().on(table.toUser, table.fromUser),
    uniqueName: unique("unique_combination").on(table.toUser, table.fromUser),
}));

export const DB_Connection_Schema = createSelectSchema(connections, {
    createdAt: (schema) => schema.createdAt.optional(),
    lastMessage: (schema) => schema.lastMessage.optional(),
    updatedAt: (schema) => schema.updatedAt.nullish(),
    acceptTimestamp: (schema) => schema.acceptTimestamp.nullish(),
});

export const DBN_Connection_Schema = createInsertSchema(connections);
export const DB_ConnectionStatus_Schema = DB_Connection_Schema.shape.connectionStatus;


export type DB_Connection = z.infer<typeof DB_Connection_Schema>;
export type DBN_Connection = z.infer<typeof DBN_Connection_Schema>;
export type DB_Connection_Status_Type = z.infer<typeof DB_ConnectionStatus_Schema>;



export default {
    connections,
    DB_Connection_Schema,
    DBN_Connection_Schema,
}