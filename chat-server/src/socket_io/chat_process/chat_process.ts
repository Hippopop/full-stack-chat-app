import { Server, Socket } from "socket.io";
import { SocketEventKeys } from "../utils/socket_event_keys";
import * as AuthorizationMiddleware from "../authorization_process/socket_authorization";

let processP2PChats = async (io: Server) => {
    const usersConnection = io.of(/^\/chat\/[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$/);

    usersConnection.use(AuthorizationMiddleware.AuthorizeSocketUser);

    usersConnection.on(SocketEventKeys.initialConnection, async (socket: Socket) => {
        /// Authorize and reassure user tokens!
        const userData = await AuthorizationMiddleware.verifyAndResignAuthorizationTokens(socket, io);

        console.log(`   --- Connected ${socket.id} + ${userData.name} ---   `);
        console.log(`Name -> ${socket.nsp.name}`);


        /// Signal Disconnect!
        socket.on(SocketEventKeys.disconnectKey, () => {
            console.log(`   --- Disconnected ${socket.id} + ${userData.name} ---   `);
        });
    });
}

export { processP2PChats }
