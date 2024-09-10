import { NextFunction, Request, Response, Router } from "express";
import { wrapperFunction } from "../request-handler";
import { AuthResModel } from "./models/auth_response";
import { LoginSchema } from "../../types/user/login-z";
import { userNotFoundError, wrongCredentialError } from "./errors/auth_errors";

import tokenizer from "../../utils/token/jwt_token";
import { success, successfullyCreated } from "../../constants/errors/error_codes";
import multerConfig from "../../utils/file_management/multer_config";
import { RegistrationUserSchema } from "./models/register";

import * as auth from "../../repositories/auth_repository";
import * as user from "../../repositories/user_repository";
import { getMediaEntry, insertMediaEntry } from "../../repositories/media_repository";
import fs from "fs";
import path from "path";
import { profilePath, profilePathString } from "../../constants/directories";
import { createActivityEntry } from "../../repositories/acitivity_repository";



const authRoute = Router();

authRoute.post(
  "/login",
  wrapperFunction({
    successCode: success,
    successMsg: "Logged in successfully!",
    errorMsg: "Login Failed!",
    schema: AuthResModel,
    businessLogic: async (req: Request, res: Response, next?: NextFunction) => {

      const loginData = LoginSchema.safeParse(req.body);
      if (loginData.success) {
        const authData = await auth.getAuthData(loginData.data.email);
        if (authData) {
          const passMatched = await auth.passwordMatches(
            loginData.data.password,
            authData.password
          );
          if (!passMatched) throw wrongCredentialError;

          const userData = await user.getUserData(authData.email);
          const [accessToken, accessTokenExpire] = tokenizer.generateToken(userData!);
          const [refreshToken, refreshTokenExpire] = tokenizer.generateRefreshToken({ uuid: authData.uuid, email: authData.email, token: accessToken });
          await auth.updateRefreshToken(authData.uuid, refreshToken);
          return {
            token: {
              token: accessToken,
              refreshToken: refreshToken,
              expiresAt: accessTokenExpire,
            },
            user: { ...(userData!), phone: authData.phone, birthdate: userData?.birthdate?.toDateString() },
          };
        } else {
          throw userNotFoundError;
        }
      } else {
        throw loginData.error;
      }
    },
  })
);

authRoute.post(
  "/register",
  multerConfig.single("image"),
  wrapperFunction({
    successCode: successfullyCreated,
    schema: AuthResModel,
    successMsg: "Registration Successfully Completed!",
    errorMsg: "Sorry! Couldn't register with the given data.",
    businessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      console.log(req.body);
      const data = RegistrationUserSchema.safeParse(req.body);
      if (data.success) {
        const authData = await auth.register(data.data);
        let imagePath: string | undefined;
        console.log(req.file?.path, req.file?.mimetype, req.file?.filename, req.file?.size, req.file?.buffer, req.file?.originalname);
        if (req.file) {
          console.log("Saving profile image!");
          const imageName = req.file.filename ?? req.file.originalname;
          console.log(imageName);
          const image = await insertMediaEntry({
            type: "profile",
            name: imageName,
            uuid: authData.uuid,
            extension: req.file.mimetype.split("/")[1] ?? "unknown",
          });
          imagePath = `/authentication/user_image?type=profile&uuid=${authData.uuid}&name=${image.name}`;
        }


        const userData = await user.createUser({
          uid: 0,
          ...authData,
          ...data.data,
          photo: imagePath,
        });
        await createActivityEntry(userData.uuid);
        const [accessToken, accessTokenExpire] = tokenizer.generateToken(userData);
        const [refreshToken, refreshExpire] = tokenizer.generateRefreshToken({ uuid: userData.uuid, email: userData.email, token: accessToken });
        await auth.updateRefreshToken(authData.uuid, refreshToken);
        return {
          token: {
            token: accessToken,
            refreshToken: refreshToken,
            expiresAt: accessTokenExpire,
          },
          user: { ...userData, phone: authData.phone, birthdate: userData?.birthdate?.toDateString() },
        };
      } else {
        throw data.error;
      }
    },
  })
);

authRoute.get(
  "/user_image",
  wrapperFunction<void>({
    successCode: 200,
    errorMsg: "Image not found!",
    successMsg: "Image fetched successfully!",
    businessLogic: async (req: Request, res: Response, next?: NextFunction) => {
      const type = "profile";
      if (req.query.type && req.query.uuid && req.query.name) {
        const image = await getMediaEntry(
          req.query.uuid as string,
          req.query.name as string,
          type,
        );
        if (image) {
          const filePath = path.join(profilePath, image.name);

          console.log(`GET -> PROFILE_PIC -> PATH -> ${filePath}`);
          const stream = fs.createReadStream(filePath);
          res.writeHead(200, { "Content-Type": "image/jpeg" });
          stream.on("open", () => {
            stream.pipe(res);
          });
          stream.on("error", (err) => {
            console.log(err);
            throw userNotFoundError;
          });
        } else {
          throw userNotFoundError;
        }
      } else {
        throw userNotFoundError;
      }
    },
  })
);

// TODO: Update profile system!




// TODO: Forget password system!

export default authRoute;
