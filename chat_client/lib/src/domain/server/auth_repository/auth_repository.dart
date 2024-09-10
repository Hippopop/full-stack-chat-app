import '../source/helpers/request_handler_provider.dart';
import '../source/helpers/response_wrapper.dart';
import 'auth_repository.dart';

export 'models/models.dart';

abstract class AuthRepository {
  final RequestHandler requestHandler;

  AuthRepository({
    required this.requestHandler,
  });

  Future<ResponseWrapper<AuthResponse>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required ({String imageName, List<int> imageData})? image,
  });

  Future<ResponseWrapper<AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<ResponseWrapper<UserToken>> refreshToken({
    required String refreshToken,
  });
}
