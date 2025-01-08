import drizzleDatabase from "../drizzle_mysql/database";
import { eq, desc, inArray } from 'drizzle-orm';
import { getCurrentTimestampSeconds } from "../drizzle_mysql/helpers/schema_snippets";
import { DB_Message, DBN_Message, messages } from "../drizzle_mysql/schemas/message_schema";
import { updateConnectionLastMessage } from "./connection_repository";

const newMessage = async (props: { msg: DBN_Message, connection: number }): Promise<DB_Message> => {
    const newMessage = await drizzleDatabase.insert(messages).values(props.msg).$returningId();
    await updateConnectionLastMessage(props.connection, newMessage[0]!.key);
    return {
        ...props.msg,
        key: newMessage[0]!.key,
        createdAt: getCurrentTimestampSeconds(),
        updatedAt: getCurrentTimestampSeconds(),
    };
};

/**
 * Updates the delivery or seen timestamp of one or more messages in the database.
 * 
 * This function updates the 'seenTime' or 'deliverTime' of messages based on the provided state.
 * If the state is "read", it sets the 'seenTime' to the current timestamp.  
 * If the state is "delivered", it sets the 'deliverTime' to the current timestamp.
 * The function can update multiple messages at once if an array of message keys is provided.
 *
 * @param key - An array of message keys (IDs) to update.
 * @param state - The new state of the message(s), either "delivered" or "read".
 */
const updateMessageTimestampState = async (key: number[], state: "delivered" | "read") => {
    await drizzleDatabase.update(messages).set({
        seenTime: state === "read" ? getCurrentTimestampSeconds() : null,
        deliverTime: state === "delivered" ? getCurrentTimestampSeconds() : null,
    }).where(inArray(messages.key, key));
};

const getAllMessagesFromConnection = async (connection: number): Promise<DB_Message[]> =>
    await drizzleDatabase.select().from(messages).where(eq(messages.connection, connection)).orderBy(desc(messages.key));


export { newMessage, getAllMessagesFromConnection, updateMessageTimestampState };