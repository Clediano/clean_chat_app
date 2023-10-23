import 'package:clean_chat_app/core/errors/exceptions.dart';
import 'package:clean_chat_app/core/errors/failure.dart';
import 'package:clean_chat_app/core/utils/typedef.dart';
import 'package:clean_chat_app/src/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/entities/user.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImpl(this._remoteDataSource);

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromAPIException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromAPIException(e));
    }
  }
}
