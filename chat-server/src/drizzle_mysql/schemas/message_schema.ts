import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { AnyMySqlColumn, int, json, mysqlTable, text, timestamp, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema_snippets";
import { users } from "./user_schema";
import { connections } from "./connection_schema";

type Attachment = {
    picture: string[],
    video: string[],
};

export const messages = mysqlTable('messages', {
    key: int('key').notNull().primaryKey(),
    text: text('text'),
    voiceNote: varchar('voice_note', { length: 256 }),
    connection: int("connection_ref").notNull().references((): AnyMySqlColumn => connections.key),
    parent: int('parent').references((): AnyMySqlColumn => messages.key),
    sender: varchar('sender', { length: 256 }).notNull().references(() => users.uuid),
    receiver: varchar('receiver', { length: 256 }).notNull().references(() => users.uuid),
    attachment: json('attachment').$type<Attachment>(),
    deliverTime: int('deliver_time'),
    seenTime: int('seen_time'),
    ...drizzleTimeFields,
});


export const DB_Message_Schema = createSelectSchema(messages, {
    parent: (schema) => schema.parent.optional(),
    voiceNote: (schema) => schema.voiceNote.optional(),
    attachment: (schema) => schema.attachment.optional(),
    createdAt: (schema) => schema.createdAt.optional(),
    deliverTime: (schema) => schema.deliverTime.nullish(),
    seenTime: (schema) => schema.seenTime.nullish(),
    updatedAt: (schema) => schema.updatedAt.nullish(),
});
export const DBN_Message_Schema = createInsertSchema(messages);

export type DB_Message = z.infer<typeof DB_Message_Schema>;
export type DBN_Message = z.infer<typeof DBN_Message_Schema>;

export default {
    messages,
    DB_Message_Schema,
    DBN_Message_Schema,
}