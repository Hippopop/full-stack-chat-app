import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RiverpodRefExtensions on Ref {
  Future<void> debounce(Duration? holdDuration) async {
    bool didDispose = false;
    onDispose(() => didDispose = true);
    await Future<void>.delayed(
        holdDuration ?? const Duration(milliseconds: 500));
    if (didDispose) {
      throw Exception('This instance of notifier has been disposed!');
    }
  }

  CancelToken get dioRequestCanceller {
    final cancelToken = CancelToken();
    onDispose(
      () => cancelToken.cancel(
        "Request is being cancelled bcz the notifier/provider got disposed!",
      ),
    );
    return cancelToken;
  }
}
