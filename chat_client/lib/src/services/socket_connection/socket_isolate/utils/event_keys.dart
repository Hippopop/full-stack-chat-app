/// Actions only related to `Isolate` and app data processing!
class IsolateEventKeys {
  static const credentials = "CREDENTIALS";
  static const socketStatus = "SOCKET_STATUS";
  static const socketConnectionError = "SOCKET_CONNECTION_ERROR";
  static const error = "SOCKET_ERROR";
}

/// Actions that mirror actions from server/socket.io!
class SocketActionKeys {
  static const freshToken = "FRESH_TOKEN";
  static const data = "DATA";
}
