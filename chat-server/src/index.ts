import express, { NextFunction, Request, Response } from "express";


const port = process.env.PORT ?? 8080;
const app = express();


app.listen(port, () =>
    console.log(`Listening on port ${port} // http://localhost:${port}/`)
);
