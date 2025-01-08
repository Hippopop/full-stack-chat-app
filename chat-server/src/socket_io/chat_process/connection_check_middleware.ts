import { Server, Socket } from "socket.io";
import tokenizer from "../../utils/token/jwt_token";
import { AuthTokenSchema } from "../../types/authentication/token-z";
import { User, UserSchema } from "../../types/user/user-z";
import { ResponseError } from "../../types/response/errors/error-z";
import { badRequest, unauthorized } from "../../constants/errors/error_codes";
import { tokenSetFromRefreshToken } from "../../routes/token/token_apis";
import { SocketActionKeys } from "../utils/socket_event_keys";
import { getUserConnectionData } from "../../repositories/connection_repository";


let checkUserConnectionState = async (socket: Socket, next: (err?: Error) => void) => {
    const pursedUser = UserSchema.safeParse(socket.data.userData);
    if (pursedUser.error) next(new ResponseError(badRequest, "User data corrupted!"));
    const user = pursedUser.data!;
    const receiver = socket.nsp.name.split('/').pop();
    if (user && receiver) {
        const connection = await getUserConnectionData(user.uuid, receiver);
        if (connection) {
            socket.data.connection = connection; next();
        } else next(new ResponseError(unauthorized, "Trying to contact a non-related user!"));
    } else next(new ResponseError(unauthorized, "Sender/Receiver credential missing!"));
};

export { checkUserConnectionState };