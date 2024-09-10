import { Server } from "socket.io";
import { Server as HttpServer } from "http";
import * as AuthorizationMiddleware from "./socket_io/authorization_process/socket_authorization";
import { SocketEventKeys } from "./socket_io/utils/socket_event_keys";
import * as UsersProcess from "./socket_io/users_process/users_process";
import * as ChatProcess from "./socket_io/chat_process/chat_process";


export const setupSocketIO = async function (httpServer: HttpServer) {
    let io = new Server(httpServer, {
        cors: { origin: "*" },
    });

    io.use(AuthorizationMiddleware.AuthorizeSocketUser);

    let userWorkspace = await UsersProcess.processUserList(io);
    let chatWorkspace = await ChatProcess.processP2PChats(io);


    io.on(SocketEventKeys.initialConnection, async (socket) => {
        /// --- Assure authorization state for the user!
        await AuthorizationMiddleware.verifyAndResignAuthorizationTokens(socket, io);

        /// --- Start of connection processing!
        console.log(`   --- Connected ${socket.id} ---   `);


        /// --- Beginning of functional processing!
        socket.emit("message", `Welcome connection! Your ID is -> ${socket.id}`);
        socket.emit("message", `Maybe your name is -> ${socket.data.userData.name}`)
        socket.emit("message", `Current path is -> ${socket.handshake.url}`);
        socket.on("message", (message: string) => {
            console.log(`Message received: ${message}`);
            socket.emit('message', `Now you can fuck off!`);
        });

        /// --- End of connection processing!
        socket.on("disconnect", (_: string) => {
            console.log(`   --- Disconnected ${socket.id} ---   `);
        });
    });


    return io;
}