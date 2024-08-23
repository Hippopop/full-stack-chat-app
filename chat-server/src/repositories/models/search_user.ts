import z from "zod";
import { DB_User_Schema } from "../../drizzle_mysql/schemas/user_schema";
import { DB_Activity_Schema } from "../../drizzle_mysql/schemas/activity_schema";
import { DB_Authentication_Schema } from "../../drizzle_mysql/schemas/auth_schema";
import { DB_Connection_Schema } from "../../drizzle_mysql/schemas/connection_schema";

export const SearchedUserDataSchema = DB_Authentication_Schema.merge(DB_User_Schema).omit({ key: true, uid: true, password: true, tokens: true, });
export type SearchedUserData = z.infer<typeof SearchedUserDataSchema>;

export const searchUserWithFriendSchema = SearchedUserDataSchema.merge(z.object({
    connection: DB_Connection_Schema.nullish().optional(),
}));
export type SearchUserWithFriend = z.infer<typeof searchUserWithFriendSchema>;
