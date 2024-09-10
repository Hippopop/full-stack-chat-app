import { Server, Socket } from "socket.io";
import tokenizer from "../../utils/token/jwt_token";
import { AuthTokenSchema } from "../../types/authentication/token-z";
import { User, UserSchema } from "../../types/user/user-z";
import { ResponseError } from "../../types/response/errors/error-z";
import { badRequest, unauthorized } from "../../constants/errors/error_codes";
import { tokenSetFromRefreshToken } from "../../routes/token/token_apis";
import { SocketActionKeys } from "../utils/socket_event_keys";


let AuthorizeSocketUser = async (socket: Socket, next: (err?: Error) => void) => {
    const match = AuthTokenSchema.omit({ expiresAt: true }).safeParse(socket.handshake.auth);
    if (match.success) {
        const tokens = match.data;

        let authData: User | undefined;
        try {
            authData = await tokenizer.verifyAccessTokenWithData(tokens.token, UserSchema);
        } catch (err) {
            console.log(err);
            if (err instanceof ResponseError && err.status === unauthorized) {
                console.log("SOCKET: (AUTHORIZATION_MIDDLEWARE) Access token expired!");
                try {
                    let newTokenSet = await tokenSetFromRefreshToken(tokens.refreshToken);
                    socket.data.freshToken = newTokenSet;
                    authData = await tokenizer.verifyAccessTokenWithData(newTokenSet.token, UserSchema);
                    next();
                } catch (error) {
                    if (error instanceof ResponseError) next(error);
                    else next(new ResponseError(badRequest, "Refresh token is corrupted!"));
                }
            } else next(new ResponseError(badRequest, "Error verifying access token"));
        }
        if (authData) {
            socket.data.userData = authData;
            console.log(`** ${authData.uuid} **`);
            next();
        } else next(new ResponseError(unauthorized, "Invalid access token!"));
    } else next(new ResponseError(unauthorized, "User credential missing!"));
};

let verifyAndResignAuthorizationTokens = async function (socket: Socket, io: Server): Promise<User> {
    if (socket.data.freshToken) {
        socket.emit(SocketActionKeys.tokenKey, socket.data.freshToken);
        delete socket.data.freshToken;
    }
    const pursedUser = UserSchema.safeParse(socket.data.userData);
    if (pursedUser.error) socket.disconnect(true);
    return pursedUser.data!;
}

export { AuthorizeSocketUser, verifyAndResignAuthorizationTokens }