import 'package:chat_client/src/constants/server/api_config.dart';
import 'package:chat_client/src/repositories/server/source/helpers/token_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'helpers/request_handler_provider.dart';

final requestHandlerProvider = Provider<RequestHandler>(
  (ref) {
    final tokenInterceptor = ref.watch(tokenInterceptorProvider);
    return RequestHandler(
      baseURl: APIConfig.baseURL,
      interceptor: [tokenInterceptor],
    );
  },
);
