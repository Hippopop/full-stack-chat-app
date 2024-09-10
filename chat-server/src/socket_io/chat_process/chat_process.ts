import { Server, Socket } from "socket.io";
import { SocketActionKeys, SocketEventKeys } from "../utils/socket_event_keys";
import * as AuthorizationMiddleware from "../authorization_process/socket_authorization";

let processP2PChats = async (io: Server) => {
    const usersConnection = io.of(/^\/chat\/[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$/);

    usersConnection.use(AuthorizationMiddleware.AuthorizeSocketUser);

    usersConnection.on(SocketEventKeys.initialConnection, async (socket: Socket) => {
        /// Authorize and reassure user tokens!
        const userData = await AuthorizationMiddleware.verifyAndResignAuthorizationTokens(socket, io);
        // Extract UUID from namespace name
        const receiver = socket.nsp.name.split('/').pop();
        console.log(`  ${userData.name} -> ${receiver} : Connected!   `);
        socket.emit(SocketActionKeys.data, []);


        /// Signal Disconnect!
        socket.on(SocketEventKeys.disconnectKey, () => {
            console.log(`  ${userData.name} -> ${receiver} : Disconnected!   `);
        });
    });
}

export { processP2PChats }
