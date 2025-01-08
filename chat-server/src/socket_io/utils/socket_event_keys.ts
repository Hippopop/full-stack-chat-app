const initialConnection = "connection";
const disconnectKey = "disconnect";
export const SocketEventKeys = {
    disconnectKey,
    initialConnection,
}


const tokenKey = "FRESH_TOKEN";
const data = "DATA";
const refresh = "REFRESH";
export const SocketActionKeys = {
    tokenKey, data, refresh,
}

export const MessageConnectionKeys = {
    message: "MESSAGE",
    newMessage: "NEW_MESSAGE",
    received: "RECEIVED",
}