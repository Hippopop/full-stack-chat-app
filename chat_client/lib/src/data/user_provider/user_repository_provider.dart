import 'package:chat_client/src/repositories/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_repository_impl.dart';

final userRepositoryProvider =
    Provider.family<UserRepository, RequestHandler>((ref, reqHandler) {
  return UserProvider(requestHandler: reqHandler);
});
