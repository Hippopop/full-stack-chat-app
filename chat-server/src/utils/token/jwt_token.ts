import tokenizer from "jsonwebtoken";
import z from "zod";
import { RefreshTokenModel, RefreshTokenSchema } from "./models/refresh_token";
import { DateTime } from "luxon";
import { createHash } from "node:crypto";
import { AccessTokenModelSchema } from "./models/token";
import { ResponseError } from "../../types/response/errors/error-z";
import { badRequest, unauthorized } from "../../constants/errors/error_codes";
import { convertDateToSecondsTimestamp, getCurrentTimestampSeconds } from "../../drizzle_mysql/helpers/schema_snippets";

const accessTokenTime = "2h";
const refreshTokenTime = "60 days";


const _tokenSchema = AccessTokenModelSchema.omit({ expire: true, timestamp: true });

function generateToken(data: string | object): [string, number] {
  const tokenSecret = process.env.ACCESS_TOKEN as string;
  const expire = convertDateToSecondsTimestamp(DateTime.now().plus({ hours: 2 }).toMillis());
  const token = tokenizer.sign(data, tokenSecret, {
    expiresIn: accessTokenTime,
  });
  return [token, expire];
}

const _generateRefreshTokenSchema = RefreshTokenSchema.omit({ sha256: true, expire: true, timestamp: true });
type _generateRefreshTokenType = z.infer<typeof _generateRefreshTokenSchema>;

function generateRefreshToken(data: _generateRefreshTokenType): [string, number] {
  const tokenSecret = process.env.REFRESH_TOKEN as string;

  const timeStamp = getCurrentTimestampSeconds();
  const expire = convertDateToSecondsTimestamp(DateTime.now().plus({ hours: 2 }).toMillis());
  const newHash = createHash("sha256");
  const hashString = newHash.digest("hex");
  const signData = {
    ...data,
    expire: expire,
    sha256: hashString,
    timestamp: timeStamp,
  } as RefreshTokenModel;

  const refreshToken = tokenizer.sign(signData, tokenSecret, {
    expiresIn: refreshTokenTime,
    //** You can set the [expiresIn] only for [Object] types!
  },);

  return [refreshToken, expire];
}

async function verifyRefreshTokenWithData<T>(
  token: string,
  schema: z.Schema<T>
): Promise<T> {
  const tokenSecret = process.env.REFRESH_TOKEN as string;
  return await new Promise<T>((resolve, reject) => {
    tokenizer.verify(token, tokenSecret, async (err, data) => {
      if (data) {
        const purifiedData = schema.safeParse(data);
        if (purifiedData.success) {
          resolve(purifiedData.data);
        } else {
          reject(purifiedData.error);
        }
      } else reject(new ResponseError(badRequest, "Invalid refresh token!"));
    })
  });

}

async function verifyAccessTokenWithData<T>(
  token: string,
  schema: z.Schema<T>
): Promise<T> {
  const tokenSecret = process.env.ACCESS_TOKEN as string;
  return new Promise<T>((resolve, reject) => {
    tokenizer.verify(token, tokenSecret, (err, data) => {
      if (data) {
        const purifiedData = schema.safeParse(data);
        if (purifiedData.success) {
          resolve(purifiedData.data);
        } else {
          reject(purifiedData.error);
        }
      } else {
        console.log(`Token isn't valid : ${err}`);
        reject(new ResponseError(unauthorized, "Attempting to reach server with an unauthorized token!"));
      }
    })
  });
}

export default {
  generateToken,
  generateRefreshToken,
  verifyAccessTokenWithData,
  verifyRefreshTokenWithData,
};
