import { Namespace, Server, Socket } from "socket.io";
import { SocketActionKeys, SocketEventKeys } from "../utils/socket_event_keys";
import * as AuthorizationMiddleware from "../authorization_process/socket_authorization";
import { createActivityEntry, switchActivityState } from "../../repositories/acitivity_repository";
import { getListOfMyHomies } from "../../repositories/user_repository";

let processUserList = async (io: Server): Promise<Namespace> => {
    const usersConnection = io.of("/users");

    usersConnection.use(AuthorizationMiddleware.AuthorizeSocketUser);

    usersConnection.on(SocketEventKeys.initialConnection, async (socket: Socket) => {
        /// Authorize and reassure user tokens!
        const userData = await AuthorizationMiddleware.verifyAndResignAuthorizationTokens(socket, io);
        /// Update user activity status!
        await switchActivityState(userData.uuid, socket.id);


        console.log(`   --- Connected ${socket.id} + ${userData.name} ---   `);
        console.log(`Name -> ${socket.nsp.name}`);

        socket.emit(SocketActionKeys.data, await getListOfMyHomies(userData.uuid));

        /// Signal Disconnect!
        socket.on(SocketEventKeys.disconnectKey, async () => {
            await switchActivityState(userData.uuid);
            console.log(`   --- Disconnected ${socket.id} + ${userData.name} ---   `);
        });
    });

    return usersConnection;
}

export { processUserList }
