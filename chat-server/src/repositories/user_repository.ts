import z from "zod";
import { eq, like, or, and, ne } from "drizzle-orm";
import drizzleDatabase from "../drizzle_mysql/database";
import { DB_User, DB_User_Schema, DBN_User, users } from "../drizzle_mysql/schemas/user_schema";
import { authentication } from "../drizzle_mysql/schemas/auth_schema";
import { SearchedUserData, SearchUserWithFriend } from "./models/search_user";
import { connections, DB_Connection, DB_Connection_Status_Type, DBN_Connection } from "../drizzle_mysql/schemas/connection_schema";
import { badRequest } from "../constants/errors/error_codes";
import { ResponseError } from "../types/response/errors/error-z";

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
  return element;
};

const searchUserData = async (uniqueData: string, userUUID: string): Promise<SearchedUserData[]> => {
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
    .where(and(
      or(
        eq(authentication.uuid, uniqueData),
        eq(authentication.phone, uniqueData),
        eq(authentication.email, uniqueData),
        like(users.name, `%${uniqueData}%`),
      ), ne(authentication.uuid, userUUID),
    ),
    );
}

const searchUserWithFriendInfo = async (uniqueQuery: string, userUUID: string): Promise<SearchUserWithFriend[]> => {
  return await drizzleDatabase.select({
    name: users.name,
    photo: users.photo,
    birthdate: users.birthdate,
    createdAt: users.createdAt,
    updatedAt: users.updatedAt,
    uuid: authentication.uuid,
    phone: authentication.phone,
    email: authentication.email,
    connection: connections,
  })
    .from(authentication)
    .innerJoin(users, eq(authentication.uuid, users.uuid))
    .where(and(
      or(
        eq(authentication.uuid, uniqueQuery),
        eq(authentication.phone, uniqueQuery),
        eq(authentication.email, uniqueQuery),
        like(users.name, `%${uniqueQuery}%`),
      ), ne(authentication.uuid, userUUID),
    ),
    ).leftJoin(connections,
      and(
        or(eq(connections.toUser, authentication.uuid), eq(connections.toUser, userUUID)),
        or(eq(connections.fromUser, authentication.uuid), eq(connections.fromUser, userUUID)),
      ),
    );
}


const requestConnection = async (to: string, from: string): Promise<DB_Connection | undefined> => {
  const validUUID = z.string().uuid().safeParse(to).success && z.string().uuid().safeParse(from).success;
  if (!validUUID) throw new ResponseError(badRequest, "UUID validation failed for sender/receiver!");

  const response = await drizzleDatabase.insert(connections).values({
    toUser: to,
    fromUser: from,
    connectionStatus: "requested",
  }).$returningId();

  if (response.length === 0 || !response.at(0)) return undefined;
  const element = response.at(0);
  return {
    key: element!.key,
    toUser: to,
    fromUser: from,
    connectionStatus: "requested",
  };
};

const updateUserConnectionStatus = async (connectionKey: number, status: DB_Connection_Status_Type, actorUUID: string): Promise<DB_Connection | undefined> => {
  const currentState = await drizzleDatabase.select().from(connections).where(eq(connections.key, connectionKey));
  if (currentState.length === 0 || !currentState.at(0)) throw new ResponseError(400, "Connection request isn't available anymore!");

  const isSender = currentState.at(0)!.fromUser == actorUUID;
  const isReceiver = currentState.at(0)!.toUser == actorUUID;
  if (!isSender && !isReceiver) throw new ResponseError(400, "Trying to update an unrelated connection!");
  if (isSender) throw new ResponseError(400, "Sender can't update the connection status!");

  const isAccepting = status == "accepted";
  const response = await drizzleDatabase.update(connections).set({
    connectionStatus: status,
    ...(isAccepting ? { acceptedAt: Date.now() } : {}),
  }).where(eq(connections.key, connectionKey));
  return {
    ...(currentState.at(0)!),
    ...(isAccepting ? { acceptedAt: Date.now() } : {}),
    connectionStatus: status,
  };
};

export { createUser, getUserData, searchUserData, searchUserWithFriendInfo, requestConnection, updateUserConnectionStatus };

