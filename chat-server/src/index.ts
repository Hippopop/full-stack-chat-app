import * as dotenv from "dotenv";

import { createClient, RedisClientType } from "redis";
import expressServer from "./express";
import { setupSocketIO } from "./socket";


dotenv.config();
const port = process.env.PORT ?? 8080;


let redisClient: RedisClientType;
let initRedis = async () => {
    redisClient = createClient();
    redisClient.on("error", (error) => console.error(`Error : ${error}`));
    await redisClient.connect();
};
initRedis();

const server = expressServer.listen(port, () => {
    console.log(`Listening on port ${port} // http://localhost:${port}/`);
});

const io = setupSocketIO(server);



