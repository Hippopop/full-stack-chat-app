import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { AnyMySqlColumn, json, mysqlTable, text, timestamp, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema_snippets";
import { users } from "./user_schema";

type Attachment = {
    picture: string[],
    video: string[],
};

export const messages = mysqlTable('messages', {
    uuid: varchar('uuid', { length: 256 }).notNull().unique(),
    text: text('text'),
    voiceNote: varchar('voice_note', { length: 256 }),
    parent: varchar('parent', { length: 256 }).references((): AnyMySqlColumn => messages.uuid),
    sender: varchar('sender', { length: 256 }).notNull().references(() => users.uuid),
    receiver: varchar('receiver', { length: 256 }).notNull().references(() => users.uuid),
    attachment: json('attachment').$type<Attachment>(),
    deliverTime: timestamp('deliver_time'),
    seenTime: timestamp('seen_time'),
    ...drizzleTimeFields,
});


export const DB_Message_Schema = createSelectSchema(messages, {
    parent: (schema) => schema.parent.optional(),
    voiceNote: (schema) => schema.voiceNote.optional(),
    attachment: (schema) => schema.attachment.optional(),
    deliverTime: (schema) => schema.deliverTime.optional(),
    seenTime: (schema) => schema.seenTime.optional(),
    createdAt: (schema) => schema.createdAt.optional(),
    updatedAt: (schema) => schema.updatedAt.optional(),
});
export const DBN_Message_Schema = createInsertSchema(messages);

export type DB_Message = z.infer<typeof DB_Message_Schema>;
export type DBN_Message = z.infer<typeof DBN_Message_Schema>;

export default {
    messages,
    DB_Message_Schema,
    DBN_Message_Schema,
}