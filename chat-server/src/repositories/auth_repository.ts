import bcrypt from "bcrypt";
import { v4 as uuIdv4 } from "uuid";
import { eq, or, SQL } from "drizzle-orm";
import drizzleDatabase from "../drizzle_mysql/database";
import { RegistrationUserModel } from "../routes/auth/models/register";
import { authentication, DB_Authentication, DB_Authentication_Schema, DBN_Authentication } from "../drizzle_mysql/schemas/auth_schema";
import { ResponseError } from "../types/response/errors/error-z";

function _uniqueMatch(uniqueData: string): SQL | undefined {
    return or(
        eq(authentication.uuid, uniqueData),
        eq(authentication.phone, uniqueData),
        eq(authentication.email, uniqueData),
    );
}


export const passwordMatches = async function (
    input: string,
    hash: string
): Promise<boolean> {
    return await bcrypt.compare(input, hash);
};


export const register = async (data: RegistrationUserModel): Promise<DB_Authentication> => {
    const uuid = uuIdv4();
    const salt = await bcrypt.genSalt();
    const hash = await bcrypt.hash(data.password, salt);

    const response = await drizzleDatabase.insert(authentication).values({
        uuid: uuid,
        password: hash,
        email: data.email,
        phone: data.phone,
    }).$returningId();

    console.log(`New registration(${JSON.stringify(response)}) -> ${response[0]!.key}`);
    const auth = DB_Authentication_Schema.safeParse({
        tokens: [],
        uuid: uuid,
        password: hash,
        phone: data.phone,
        email: data.email,
        key: response[0]!.key,
    });

    if (auth.success) {
        return auth.data;
    } else {
        throw auth.error;
    }
};


export const getAuthData = async (
    uniqueData: string
): Promise<DB_Authentication | undefined> => {
    const response = await drizzleDatabase.select().from(authentication).where(_uniqueMatch(uniqueData));

    if (response.length === 0 || !response.at(0)) return undefined;

    const element = response.at(0);
    const purifiedData = DB_Authentication_Schema.safeParse({ ...element });
    if (purifiedData.success) {
        return purifiedData.data;
    } else {
        throw purifiedData.error;
    }
};


export const updateRefreshToken = async function (
    uniqueData: string,
    newToken: string,
    oldToken: string | null = null,
): Promise<void> {
    let response = await drizzleDatabase.select({ token: authentication.tokens }).from(authentication).where(_uniqueMatch(uniqueData));
    if (response.length === 0) {
        throw new ResponseError(400, "Didn't found a user for the given data!");
    }
    const tokensEmpty = !(response.at(0)?.token[0]);
    let currentTokenList: string[] = [];
    if (!tokensEmpty) {
        console.log(`Current token type => ${typeof response[0]!.token}`);
        const token = response[0]!.token as unknown as string;
        currentTokenList = JSON.parse(token);
    }

    if (oldToken && currentTokenList.includes(oldToken)) {
        currentTokenList = currentTokenList.filter((val) => val != oldToken);
    }
    currentTokenList.push(newToken);

    const transaction = await drizzleDatabase.update(authentication).set({ tokens: currentTokenList }).where(_uniqueMatch(uniqueData));
};

export const getRefreshToken = async function (
    uniqueData: string
): Promise<string[] | undefined> {
    const response = await drizzleDatabase.select({ token: authentication.tokens }).from(authentication).where(_uniqueMatch(uniqueData));
    return response[0]?.token;
};

export default {
    getAuthData,
    register,
    passwordMatches,
    getRefreshToken,
    updateRefreshToken,
};
