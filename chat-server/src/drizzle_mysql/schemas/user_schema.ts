import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { date, int, mysqlTable, text, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema_snippets";
import { authentication } from "./auth_schema";

export const users = mysqlTable('users', {
    uid: int("uid").autoincrement().primaryKey(),
    uuid: varchar('uuid', { length: 256, }).notNull().unique().references(() => authentication.uuid),
    name: text('name').notNull(),
    email: varchar("email", { length: 256 }).notNull().unique().references(() => authentication.email),
    photo: text('photo'),
    birthdate: date('birthdate', { mode: "date" }),
    ...drizzleTimeFields,
});

export const DB_User_Schema = createSelectSchema(users, {
    photo: (schema) => schema.photo.optional(),
    birthdate: (schema) => schema.birthdate.optional(),
    createdAt: (schema) => schema.createdAt.optional(),
    updatedAt: (schema) => schema.updatedAt.optional(),
});
export const DBN_User_Schema = createInsertSchema(users);

export type DB_User = z.infer<typeof DB_User_Schema>;
export type DBN_User = z.infer<typeof DBN_User_Schema>;


export default {
    users,
    DB_User_Schema,
    DBN_User_Schema,
}