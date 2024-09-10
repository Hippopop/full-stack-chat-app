import path from "path";
import express from "express";
import { readFile } from "node:fs/promises";

import userRoute from "./routes/user/user_apis";
import tokenRoute from "./routes/token/token_apis";
import { publicPath } from "./constants/directories";
import authRoute from "./routes/authentication/auth-apis";

const expressApp = express();
expressApp.use(express.json());
expressApp.use(express.static(publicPath));

expressApp.use("/users", userRoute);
expressApp.use("/token", tokenRoute);
expressApp.use("/authentication", authRoute);

expressApp.get("/", (_, res, __) => res.sendFile(path.join(publicPath, 'index.html')));

expressApp.all("*", async (req, res, __) => {
    const file = await readFile(path.join(publicPath, 'error.html'), "utf8");
    console.log(`Trying to reach an unavailable path --> ${req.url}`);
    const formattedFile = file.replace("{%}", req.url);
    return res.send(formattedFile);
});

export default expressApp;