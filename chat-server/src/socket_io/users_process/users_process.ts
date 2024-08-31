import { Namespace, Server, Socket } from "socket.io";
import { SocketEventKeys } from "../utils/socket_event_keys";
import * as AuthorizationMiddleware from "../authorization_process/socket_authorization";

let processUserList = async (io: Server): Promise<Namespace> => {
    const usersConnection = io.of("/users");

    usersConnection.use(AuthorizationMiddleware.AuthorizeSocketUser);

    usersConnection.on(SocketEventKeys.initialConnection, async (socket) => {
        /// Authorize and reassure user tokens!
        const userData = await AuthorizationMiddleware.verifyAndResignAuthorizationTokens(socket, io);

        console.log(`   --- Connected ${socket.id} + ${userData.name} ---   `);
        console.log(`Name -> ${socket.nsp.name}`);

        /// Signal Disconnect!
        socket.on(SocketEventKeys.disconnectKey, () => {
            console.log(`   --- Disconnected ${socket.id} + ${userData.name} ---   `);
        });
    });

    return usersConnection;
}

export { processUserList }
