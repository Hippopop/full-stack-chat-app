import z from "zod";
import { NextFunction, Request, Response, Router } from "express";
import { wrapperFunction } from "../request-handler";
import { badRequest, success, successfullyChanged, successfullyCreated } from "../../constants/errors/error_codes";
import { searchUserWithFriendSchema } from "../../repositories/models/search_user";
import { requestConnection, searchUserWithFriendInfo, updateUserConnectionStatus } from "../../repositories/user_repository";
import { ResponseError } from "../../types/response/errors/error-z";
import { User } from "../../types/user/user-z";
import { DB_Connection_Schema, DB_ConnectionStatus_Schema } from "../../drizzle_mysql/schemas/connection_schema";


const userRoute = Router();

userRoute.get(
    "/search",
    wrapperFunction({
        authenticate: true,
        successCode: success,
        schema: searchUserWithFriendSchema.array(),
        successMsg: "Got the user list from server!",
        errorMsg: "Sorry! Couldn't get the user list for the given query.",
        businessLogic: async (req: Request, res: Response, next?: NextFunction, user?: User) => {
            let { query } = req.query;
            if (!query || !(typeof query == 'string') || query.length < 4) throw new ResponseError(badRequest, "The search query is either missing, too short, or not a string!");
            const isEmail = z.string().email().safeParse(query).success;
            if (isEmail) (query as string).toLowerCase();
            let response = await searchUserWithFriendInfo(query as string, user!.uuid);
            console.log(JSON.stringify(response));
            return response;
        },
    })
);

userRoute.post(
    "/request_connection/:uuid",
    wrapperFunction({
        authenticate: true,
        successCode: successfullyCreated,
        schema: DB_Connection_Schema,
        successMsg: "Connection request sent!",
        errorMsg: "Failed to request connection with the user!.",
        businessLogic: async (req: Request, res: Response, next?: NextFunction, user?: User) => {
            let { uuid } = req.params;
            if (!uuid || !user?.uuid) throw new ResponseError(badRequest, "Missing sender/receiver UUID!");
            let response = await requestConnection(uuid, user!.uuid);
            console.log(JSON.stringify(response));
            return response;
        },
    })
);

userRoute.post(
    "/update_connection/:key",
    wrapperFunction({
        authenticate: true,
        successCode: successfullyChanged,
        schema: DB_Connection_Schema,
        successMsg: "Connection state updated!",
        errorMsg: "Failed to update connection with the user!.",
        businessLogic: async (req: Request, res: Response, next?: NextFunction, user?: User) => {
            const keySchema = DB_Connection_Schema.shape.key;
            let { key } = req.params;
            let numberKey = (() => {
                try { return parseInt(key!); }
                catch (_) { throw new ResponseError(badRequest, "Missing/Malformed connection key!"); };
            })();

            const bodySchema = z.object({ status: DB_ConnectionStatus_Schema });
            const body = bodySchema.safeParse(req.body);
            if (!body.success) throw body.error;

            let response = await updateUserConnectionStatus(numberKey, body.data.status, user!.uuid);
            return response;
        },
    })
);

export default userRoute;
