import z from "zod";
import { DB_User_Schema } from "../../drizzle_mysql/schemas/user_schema";
import { DB_Activity_Schema } from "../../drizzle_mysql/schemas/activity_schema";
import { DB_Authentication_Schema } from "../../drizzle_mysql/schemas/auth_schema";

export const SearchedUserSchema = DB_Authentication_Schema.merge(DB_User_Schema).omit({ key: true, uid: true, password: true, tokens: true, });

export type SearchedUser = z.infer<typeof SearchedUserSchema>;