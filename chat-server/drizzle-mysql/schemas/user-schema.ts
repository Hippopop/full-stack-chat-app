import { z } from "zod";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { date, foreignKey, int, mysqlTable, serial, text, uniqueIndex, varchar } from 'drizzle-orm/mysql-core';
import { drizzleTimeFields } from "../helpers/schema-snippets";
import { authentication } from "./auth-schema";

export const users = mysqlTable('users', {
    ...drizzleTimeFields,
    photo: text('photo'),
    name: text('name').notNull(),
    birthdate: date('birthdate', { mode: "date" }),
    uid: int("uid").autoincrement().primaryKey(),
    uuid: varchar('uuid', { length: 256, }).notNull().unique().references(() => authentication.uuid),
    email: varchar("email", { length: 256 }).notNull().unique().references(() => authentication.email),
});

export const DB_User_Schema = createSelectSchema(users);
export const DBN_User_Schema = createInsertSchema(users);

export type DB_User = z.infer<typeof DB_User_Schema>;
export type DBN_User = z.infer<typeof DBN_User_Schema>;
