import 'package:clean_chat_app/src/modules/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() async {
    throw UnimplementedError();
  }
}
