import { Server, Socket } from "socket.io";
import { MessageConnectionKeys, SocketActionKeys, SocketEventKeys } from "../utils/socket_event_keys";
import * as AuthorizationMiddleware from "../authorization_process/socket_authorization";
import * as ConnectionCheckMiddleware from "./connection_check_middleware";
import { DB_Connection_Schema } from "../../drizzle_mysql/schemas/connection_schema";
import { getAllMessagesFromConnection, newMessage, updateMessageTimestampState } from "../../repositories/message_repository";

let processP2PChats = async (io: Server) => {
    const chatConnection = io.of(/^\/chat\/[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$/);

    /// Middlewares!
    chatConnection.use(AuthorizationMiddleware.AuthorizeSocketUser);
    chatConnection.use(ConnectionCheckMiddleware.checkUserConnectionState);

    /// Socket Events!
    chatConnection.on(SocketEventKeys.initialConnection, async (socket: Socket) => {
        const userData = await AuthorizationMiddleware.verifyAndResignAuthorizationTokens(socket, io);

        // Extract UUID from namespace name
        const receiver = socket.nsp.name.split('/').pop()!;
        const connection = DB_Connection_Schema.parse(socket.data.connection);
        if (connection.connectionStatus !== "accepted") {
            socket.disconnect();
        }

        //User message management part!
        const roomName = `connection-room:${connection.key}`;
        socket.join(roomName);
        console.log(`  ${userData.name} -> ${receiver} : Connected!  Joined ${roomName}!  `);


        socket.onAny((message) => {
            console.log(`Received ${message}`);
        });

        //join a room with the connection key!
        // emit event on that room!
        chatConnection.to(roomName)
            .emit(SocketActionKeys.data, await getAllMessagesFromConnection(connection.key));
        socket.emit(SocketActionKeys.data, await getAllMessagesFromConnection(connection.key));


        socket.on(MessageConnectionKeys.message, async (message, callback) => {
            const messageData = await newMessage({
                connection: connection.key,
                msg: {
                    text: message,
                    receiver: receiver,
                    sender: userData.uuid,
                    connection: connection.key,
                },
            });
            chatConnection.in(roomName).emit(MessageConnectionKeys.newMessage, messageData);
            // chatConnection.in(roomName).emit(SocketActionKeys.data, await getAllMessagesFromConnection(connection.key));
        });

        socket.on(MessageConnectionKeys.received, async (messageKeys) => {
            await updateMessageTimestampState(messageKeys, "delivered");
            chatConnection.in(roomName).emit(SocketActionKeys.data, await getAllMessagesFromConnection(connection.key));
        });


        /// Signal Disconnect!
        socket.on(SocketEventKeys.disconnectKey, () => {
            console.log(`  ${userData.name} -> ${receiver} : Disconnected!   `);
        });
    });
}

export { processP2PChats }

