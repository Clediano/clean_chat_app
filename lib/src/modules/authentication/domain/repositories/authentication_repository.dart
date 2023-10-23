import 'package:clean_chat_app/core/utils/typedef.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
