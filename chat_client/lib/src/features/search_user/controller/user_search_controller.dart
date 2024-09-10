import 'dart:developer';

import 'package:chat_client/src/data/user_provider/user_repository_provider.dart';
import 'package:chat_client/src/domain/repository.dart';
import 'package:chat_client/src/domain/server/source/config_provider.dart';
import 'package:chat_client/src/domain/server/user_repository/models/connection_data.dart';
import 'package:chat_client/src/utilities/extensions/riverpod_ref_extensions.dart';
import 'package:chat_client/src/utilities/scaffold_utils/snackbar_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTextProvider = StateProvider.autoDispose<String?>((ref) => null);

final userSearchControllerProvider =
    AutoDisposeAsyncNotifierProvider<UserSearchNotifier, List<UserData>>(
  UserSearchNotifier.new,
);

class UserSearchNotifier extends AutoDisposeAsyncNotifier<List<UserData>> {
  late UserRepository _repository;
  late RequestHandler _requestHandler;

  @override
  build() async {
    _requestHandler = ref.watch(requestHandlerProvider);
    _repository = ref.watch(userRepositoryProvider(_requestHandler));

    final query = ref.watch(searchTextProvider);
    if (query == null || query.length < 4) return [];

    await ref.debounce(1.seconds);
    return await getUsers(
      query: query,
      cancelToken: ref.dioRequestCanceller,
    );
  }

  Future<List<UserData>> getUsers({
    required String query,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _repository.searchUsers(query: query);
      if (response.isSuccess) {
        return response.data!;
      } else {
        showToastError(response.msg);
        throw response.msg;
      }
    } catch (e, s) {
      log("#GET_USERS", error: e, stackTrace: s);
      if (e is RequestException) {
        e.handleError(defaultMessage: "Unexpected error occurred!");
      }
      rethrow;
    }
  }

  void updateConnectionRequest({
    CancelToken? cancelToken,
    required int connectionKey,
    required ConnectionStatus status,
  }) async {
    try {
      final baseState = state;
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          final response = await _repository.updateUserConnection(
            connectionKey: connectionKey,
            newStatus: status,
          );
          if (response.isError) throw response.msg;
          showToastSuccess(response.msg);
          return [
            for (final user in baseState.requireValue)
              if (user.connection?.key == connectionKey)
                user.copyWith(connection: response.data)
              else
                user,
          ];
        },
      );
    } catch (e, s) {
      log("#UPDATE_CONNECTION_REQUEST", error: e, stackTrace: s);
      if (e is RequestException) {
        e.handleError(defaultMessage: "Unexpected error occurred!");
      }
      rethrow;
    }
  }

  void requestConnection({
    CancelToken? cancelToken,
    required String userUUID,
  }) async {
    try {
      final baseState = state;
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          final response =
              await _repository.requestConnection(userUUID: userUUID);
          if (response.isError) throw response.msg;
          showToastSuccess(response.msg);
          return [
            for (final user in baseState.requireValue)
              if (user.uuid == userUUID)
                user.copyWith(connection: response.data)
              else
                user,
          ];
        },
      );
    } catch (e, s) {
      log("#REQUEST_CONNECTION", error: e, stackTrace: s);
      if (e is RequestException) {
        e.handleError(defaultMessage: "Unexpected error occurred!");
      }
      rethrow;
    }
  }
}
