import 'package:chat_client/src/data/auth_provider/auth_repository_provider.dart';
import 'package:chat_client/src/repositories/server/auth_repository/auth_repository.dart';
import 'package:chat_client/src/repositories/server/source/config_provider.dart';
import 'package:chat_client/src/repositories/server/source/helpers/request_handler_provider.dart';
import 'package:chat_client/src/services/authentication/authentication_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/registration_model/registration_state.dart';

final registrationControllerProvider =
    AsyncNotifierProvider<RegistrationStateNotifier, RegistrationState>(
  RegistrationStateNotifier.new,
);

class RegistrationStateNotifier extends AsyncNotifier<RegistrationState> {
  late AuthRepository _repository;
  late RequestHandler _requestHandler;

  @override
  RegistrationState build() {
    _requestHandler = ref.watch(requestHandlerProvider);
    _repository = ref.watch(authRepositoryProvider(_requestHandler));
    return const RegistrationState();
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

  void switchPasswordVisibility() {
    final currentState = state.requireValue;
    state = AsyncValue.data(currentState.copyWith(
      passwordVisibility: !currentState.passwordVisibility,
    ));
  }

  void setName(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      name: newState,
    ));
  }

  void setMail(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      email: newState,
    ));
  }

  void setImagePath(String imageName, List<int> imageData) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      imagePath: (imageName: imageName, imageData: imageData),
    ));
  }

  void setPhoneCode(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      phoneCode: newState,
    ));
  }

  void setPhoneNumber(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      phoneNumber: newState,
    ));
  }

  void setPassword(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      password: newState,
    ));
  }

  void setConfirmedPassword(String newState) {
    final currentValue = state.requireValue;
    state = AsyncValue.data(currentValue.copyWith(
      confirmPassword: newState,
    ));
  }

  void attemptRegistration() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentValue = state.requireValue;
      final phoneNumber =
          "${currentValue.phoneCode}${currentValue.phoneNumber}";
      final res = await _repository.register(
        phone: phoneNumber,
        name: currentValue.name!,
        email: currentValue.email!,
        password: currentValue.password!,
        image: currentValue.imagePath,
      );
      if (res.isSuccess) {
        final notifier = ref.read(authStateNotifierProvider.notifier);
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
            msg: res.error?.first.description ??
                "Response came with an unknown error!",
          ),
        );
      }
    });
  }
}
