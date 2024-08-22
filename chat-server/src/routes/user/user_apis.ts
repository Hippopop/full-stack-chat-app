import z from "zod";
import { NextFunction, Request, Response, Router } from "express";
import { wrapperFunction } from "../request-handler";
import { badRequest, success } from "../../constants/errors/error_codes";
import { SearchedUserSchema } from "../../repositories/models/search_user";
import { searchUser } from "../../repositories/user_repository";
import { ResponseError } from "../../types/response/errors/error-z";
import { resolve } from "path";


const userRoute = Router();

userRoute.get(
    "/search",
    wrapperFunction({
        successCode: success,
        schema: SearchedUserSchema.array(),
        successMsg: "Got the user list from server!",
        errorMsg: "Sorry! Couldn't get the user list for the given query.",
        businessLogic: async (req: Request, res: Response, next?: NextFunction) => {
            let { query } = req.query;
            if (!query || !(typeof query == 'string') || query.length < 4) throw new ResponseError(badRequest, "The search query is either missing, too short, or not a string!");
            const isEmail = z.string().email().safeParse(query).success;
            if (isEmail) (query as string).toLowerCase();
            return searchUser(query);
        },
    })
);

export default userRoute;
