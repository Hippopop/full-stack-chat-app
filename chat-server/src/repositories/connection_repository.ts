import z from "zod";
import { eq, or, and, ne } from "drizzle-orm";
import drizzleDatabase from "../drizzle_mysql/database";
import { users } from "../drizzle_mysql/schemas/user_schema";
import { connections, DB_Connection, DB_Connection_Status_Type, DBN_Connection } from "../drizzle_mysql/schemas/connection_schema";
import { badRequest } from "../constants/errors/error_codes";
import { ResponseError } from "../types/response/errors/error-z";
import { getCurrentTimestampSeconds } from "../drizzle_mysql/helpers/schema_snippets";
import { messages } from "../drizzle_mysql/schemas/message_schema";
import { activities } from "../drizzle_mysql/schemas/activity_schema";
import { HomieInfo } from "./models/homie_info";

const getUserConnectionData = async (userOne: string, userTwo: string): Promise<DB_Connection | undefined> => {
  const response = await drizzleDatabase.select().from(connections).where(and(
    or(eq(connections.toUser, userOne), eq(connections.toUser, userTwo)),
    or(eq(connections.fromUser, userOne), eq(connections.fromUser, userTwo)),
  ),
  );
  return response.at(0);
}

const updateConnectionLastMessage = async (connectionKey: number, messageKey: number): Promise<boolean> => {
  const response = await drizzleDatabase.update(connections).set({ lastMessage: messageKey }).where(eq(connections.key, connectionKey));
  return response.length > 0;
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

  const isAccepting = (status === "accepted");
  console.log(`isAccepting ${JSON.stringify(isAccepting ? { acceptedAt: getCurrentTimestampSeconds() } : {})}`);
  const response = await drizzleDatabase.update(connections).set({
    connectionStatus: status,
    ...(isAccepting ? { acceptTimestamp: getCurrentTimestampSeconds() } : {}),
  }).where(eq(connections.key, connectionKey));
  return {
    ...(currentState.at(0)!),
    ...(isAccepting ? { acceptedAt: getCurrentTimestampSeconds() } : {}),
    connectionStatus: status,
  };
};

const getListOfMyHomies = async (uuid: string): Promise<HomieInfo[]> => {
  return await drizzleDatabase.select(
    {
      homie: {
        uuid: users.uuid,
        name: users.name,
        photo: users.photo,
        isActive: activities.isActive,
        lastActivity: activities.updatedAt,
      },
      connection: {
        key: connections.key,
        status: connections.connectionStatus,
        acceptedAt: connections.acceptTimestamp,
      },
      message: messages,
    }
  ).from(connections)
    .where(
      and(
        or(eq(connections.fromUser, uuid), eq(connections.toUser, uuid)),
        eq(connections.connectionStatus, "accepted")
      )
    )
    .innerJoin(users,
      or(
        and(eq(users.uuid, connections.fromUser), ne(connections.fromUser, uuid)),
        and(eq(users.uuid, connections.toUser), ne(connections.toUser, uuid)),
      )
    )
    .leftJoin(messages, eq(connections.lastMessage, messages.key))
    .leftJoin(activities, eq(users.uuid, activities.user));
};


export { requestConnection, updateUserConnectionStatus, getListOfMyHomies, getUserConnectionData, updateConnectionLastMessage };
