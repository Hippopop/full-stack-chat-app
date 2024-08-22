import { eq, like, or } from "drizzle-orm";
import drizzleDatabase from "../drizzle_mysql/database";
import { DB_User, DB_User_Schema, DBN_User, users } from "../drizzle_mysql/schemas/user_schema";
import { authentication } from "../drizzle_mysql/schemas/auth_schema";
import { SearchedUser } from "./models/search_user";

const createUser = async (data: DBN_User): Promise<DB_User> => {
  const response = await drizzleDatabase.insert(users).values({
    uuid: data.uuid,
    email: data.email,
    name: data.name,
    photo: data.photo,
    birthdate: data.birthdate
  }).$returningId();
  return DB_User_Schema.parse({ ...data, uid: response[0]!.uid });
};

const getUserData = async (uniqueData: string): Promise<DB_User | undefined> => {
  let uid = parseInt(uniqueData);
  const response = await drizzleDatabase.select().from(users).where(or(
    eq(users.uuid, uniqueData),
    eq(users.email, uniqueData),
    uid ? eq(users.uid, uid) : undefined,
  ));

  if (response.length === 0 || !response.at(0)) return undefined;
  const element = response.at(0);
  console.log(element);
  return element;
};

const searchUser = async (uniqueData: string): Promise<SearchedUser[]> => {
  return await drizzleDatabase.select({
    name: users.name,
    photo: users.photo,
    birthdate: users.birthdate,
    createdAt: users.createdAt,
    updatedAt: users.updatedAt,
    uuid: authentication.uuid,
    phone: authentication.phone,
    email: authentication.email,
  })
    .from(authentication)
    .innerJoin(users, eq(authentication.uuid, users.uuid))
    .where(or(
      eq(authentication.uuid, uniqueData),
      eq(authentication.phone, uniqueData),
      eq(authentication.email, uniqueData),
      like(users.name, `%${uniqueData}%`),
    ));
}

export { createUser, getUserData, searchUser };

