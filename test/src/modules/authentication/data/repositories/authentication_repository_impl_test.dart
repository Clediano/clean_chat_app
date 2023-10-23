import 'package:clean_chat_app/core/errors/exceptions.dart';
import 'package:clean_chat_app/core/errors/failure.dart';
import 'package:clean_chat_app/src/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_chat_app/src/modules/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthenticationRepositoryImpl(remoteDataSource);
  });

  const tException = APIException(
    message: 'Unknown Error Occurred',
    statusCode: 500,
  );

  group('createUser', () {
    const name = 'any name';
    const avatar = 'any avatar';
    const createdAt = 'any created at';

    test(
        'should call the [RemoteDataSource.createUser] and complete '
        'successfully when the call to the remote source is successful',
        () async {
      // Arrange
      when(
        () => remoteDataSource.createUser(
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
          createdAt: any(named: 'createdAt'),
        ),
      ).thenAnswer((_) async => Future.value());

      // Act
      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      // Assert
      expect(result, equals(const Right(null)));
      verify(
        () => remoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    test(
        'should return a [APIFailure] when the call to the remote source '
        'is unsuccessful', () async {
      // Arrange
      when(
        () => remoteDataSource.createUser(
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
          createdAt: any(named: 'createdAt'),
        ),
      ).thenThrow(tException);

      // Act
      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      // Assert
      expect(
        result,
        equals(
          Left(APIFailure(
            message: tException.message,
            statusCode: tException.statusCode,
          )),
        ),
      );
      verify(() => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          )).called(1);
    });
  });

  group('getUsers', () {
    test(
        'should call the [RemoteDataSource.getUsers] and return [List<Users>] '
        'when the call to the remote source is successful', () async {
      // Arrange
      when(() => remoteDataSource.getUsers()).thenAnswer(
        (_) async => [],
      );

      // Act
      final result = await repoImpl.getUsers();

      // Assert
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    test(
        'should return a [APIFailure] when the call to the remote source '
        'is unsuccessful', () async {
      // Arrange
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      // Act
      final result = await repoImpl.getUsers();

      // Assert
      expect(
        result,
        equals(Left(APIFailure.fromAPIException(tException))),
      );
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
