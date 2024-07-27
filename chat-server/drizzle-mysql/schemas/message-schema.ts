import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { AnyMySqlColumn, json, mysqlTable, text, timestamp, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema-snippets";
import { users } from "./user-schema";

type Attachment = {
    picture: string[],
    video: string[],
};

export const messages = mysqlTable('messages', {
    ...drizzleTimeFields,
    text: text('text'),
    seenTime: timestamp('seen_time'),
    deliverTime: timestamp('deliver_time'),
    voiceNote: varchar('voice_note', { length: 256 }),
    attachment: json('attachment').$type<Attachment>(),
    uuid: varchar('uuid', { length: 256 }).notNull().unique(),
    sender: varchar('sender', { length: 256 }).notNull().references(() => users.uuid),
    receiver: varchar('receiver', { length: 256 }).notNull().references(() => users.uuid),
    parent: varchar('parent', { length: 256 }).references((): AnyMySqlColumn => messages.uuid),
});


export const DB_Message_Schema = createSelectSchema(messages);
export const DBN_Message_Schema = createInsertSchema(messages);

export type DB_Message = z.infer<typeof DB_Message_Schema>;
export type DBN_Message = z.infer<typeof DBN_Message_Schema>;