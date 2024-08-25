import * as dotenv from "dotenv";
import * as path from "path";

import { createClient, RedisClientType } from "redis";
import express from "express";
import { Server } from "socket.io";
import authRoute from "./routes/authentication/auth-apis";
import tokenRoute from "./routes/token/token_apis";
import { publicPath } from "./constants/directories";
import userRoute from "./routes/user/user_apis";
import * as AuthorizationMiddleware from "./socket/authorization_process/socket_authorization";


dotenv.config();
const port = process.env.PORT ?? 8080;

const app = express();
let redisClient: RedisClientType;

let initRedis = async () => {
    redisClient = createClient();
    redisClient.on("error", (error) => console.error(`Error : ${error}`));
    await redisClient.connect();
};
initRedis();

app.use(express.json());
app.use(express.static(publicPath));

app.use("/users", userRoute);
app.use("/token", tokenRoute);
app.use("/authentication", authRoute);

app.get("/", (req, res, next) => {
    return res.sendFile(path.resolve("./public/index.html"));
});
app.all("*", (req, res, next) => {
    console.log(`Trying to reach an unavailable path --> ${req.path}`);
    return res.send("<h1>Entered to a unknown World!</h1>");
});

const server = app.listen(port, () => {
    console.log(`Listening on port ${port} // http://localhost:${port}/`);
});


// Socket system!
const io = new Server(server, {
    cors: { origin: "*" }
});

io.use(AuthorizationMiddleware.AuthorizeSocketUser);

io.on("connection", async (socket) => {
    ///
    await AuthorizationMiddleware.verifyAndResignAuthorizationTokens(socket, io);

    /// --- Start of connection processing!
    console.log(`   --- Connected ${socket.id} ---   `);

    /// --- Beginning of functional processing!
    socket.emit("message", `Welcome connection! Your ID is -> ${socket.id}`);
    socket.emit("message", `Maybe your name is -> ${socket.data.userData.name}`)
    socket.emit("message", `Current path is -> ${socket.handshake.url}`);
    socket.on("message", (message) => {
        console.log(`Message received: ${message}`);
        socket.emit('message', `Now you can fuck off!`);
    });

    /// --- End of connection processing!
    socket.on("disconnect", (_) => {
        console.log(`   --- Disconnected ${socket.id} ---   `);
    });
});
