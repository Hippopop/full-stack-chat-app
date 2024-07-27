import * as dotenv from "dotenv";
import { Server } from "socket.io";
import { createServer } from "http";
import express, { NextFunction, Request, Response } from "express";

dotenv.config();
const port = process.env.PORT ?? 8080;


const app = express();
const httpServer = createServer(app);


const socket = new Server(httpServer, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"],
    }
},);

socket.on("connection", (socket) => {
    console.log(`Socket on port ${port}! New connection ${socket.id}`)

    socket.emit(`Welcome connection! Your ID is -> ${socket.id}`);
});

httpServer.listen(port, () =>
    console.log(`Listening on port ${port} // http://localhost:${port}/`)
);
