import 'package:chat_client/src/data/auth_provider/auth_repository_impl.dart';
import 'package:chat_client/src/repositories/server/source/helpers/request_handler_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider =
    Provider.family<AuthProvider, RequestHandler>((ref, reqHandler) {
  return AuthProvider(requestHandler: reqHandler);
});
