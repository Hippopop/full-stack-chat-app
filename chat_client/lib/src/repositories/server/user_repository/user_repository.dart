import '../../repository.dart';
export 'models/user_data.dart';

abstract class UserRepository {
  final RequestHandler requestHandler;

  UserRepository({
    required this.requestHandler,
  });

  Future<ResponseWrapper<List<UserData>>> searchUsers({required String query});
}
