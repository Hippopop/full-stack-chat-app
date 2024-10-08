import 'package:chat_client/src/data/auth_provider/auth_repository_provider.dart';
import 'package:chat_client/src/domain/server/auth_repository/auth_repository.dart';
import 'package:chat_client/src/domain/server/source/config_provider.dart';
import 'package:chat_client/src/domain/server/source/helpers/request_handler_provider.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/login_model/login_state.dart';

final loginControllerProvider =
    AsyncNotifierProvider<LoginStateNotifier, LoginState>(
  LoginStateNotifier.new,
);

class LoginStateNotifier extends AsyncNotifier<LoginState> {
  late RequestHandler _requestHandler;
  late AuthRepository _repository;

  @override
  LoginState build() {
    _requestHandler = ref.watch(requestHandlerProvider);
    _repository = ref.watch(authRepositoryProvider(_requestHandler));
    return const LoginState();
  }

  void removeMessage() {
    final currentState = state.requireValue;
    state = AsyncValue.data(currentState.copyWith(responseMsg: null));
  }

  void setResponseMsg({required String msg, int level = 0}) {
    final currentState = state.requireValue;
    state = AsyncValue.data(
      currentState.copyWith(
        responseMsg: (level: level, msg: msg),
      ),
    );
  }

  void switchRememberMe() {
    final currentState = state.requireValue;
    state = AsyncValue.data(currentState.copyWith(
      remember: !currentState.remember,
    ));
  }

  void setLoginMail(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      email: newState,
    ));
  }

  void setLoginPassword(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      password: newState,
    ));
  }

  void attemptLogin() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentValue = state.requireValue;
      final res = await _repository.login(
        email: currentValue.email!,
        password: currentValue.password!,
      );
      if (res.isSuccess) {
        final notifier = ref.read(userStateNotifierProvider.notifier);
        await notifier.saveUserToken(res.data!.token);
        await notifier.saveAppUser(res.data!.user);
        return currentValue.copyWith(
          authorized: true,
          responseMsg: (level: 1, msg: res.msg),
        );
      } else {
        return currentValue.copyWith(
          responseMsg: (
            level: res.status ?? 0,
            msg: res.error!.first.description
          ),
        );
      }
    });
  }
}
