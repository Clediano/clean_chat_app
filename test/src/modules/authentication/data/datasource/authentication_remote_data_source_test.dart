import 'dart:convert';

import 'package:clean_chat_app/core/errors/exceptions.dart';
import 'package:clean_chat_app/core/utils/constants.dart';
import 'package:clean_chat_app/src/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_chat_app/src/modules/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  late Client client;
  late AuthenticationRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the status code is 20*', () async {
      when(() => client.post(any(),
          body: any(named: 'body'),
          headers: {'Content-Type': 'application/json'})).thenAnswer(
        (_) async => Response('User created Successfully', 201),
      );

      final methodCall = remoteDataSource.createUser;

      expect(
          methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes);

      verify(
        () => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
            headers: {'Content-Type': 'application/json'}),
      ).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
      'should throw [APIException] when the status code is not 20*',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => Response('Invalid user', 400),
        );

        final methodCall = remoteDataSource.createUser;

        expect(
          () async => methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          throwsA(const APIException(message: 'Invalid user', statusCode: 400)),
        );
        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getUser', () {
    const tUsers = [UserModel.empty()];
    test('should return a [List<User>] when the status code is 200', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => Response(jsonEncode([tUsers.first.toMap()]), 200),
      );

      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
          .called(1);
      verifyNoMoreInteractions(client);
    });

    test(
      'should throw [APIException] when the status code is not 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => Response('Internal server error', 500),
        );

        final methodCall = remoteDataSource.getUsers;

        expect(
          () => methodCall(),
          throwsA(
            const APIException(
              message: 'Internal server error',
              statusCode: 500,
            ),
          ),
        );
        verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint)))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
