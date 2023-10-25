import 'dart:convert';

import 'package:clean_chat_app/core/errors/exceptions.dart';
import 'package:clean_chat_app/core/utils/constants.dart';
import 'package:clean_chat_app/core/utils/typedef.dart';
import 'package:clean_chat_app/src/modules/authentication/data/models/user_model.dart';
import 'package:http/http.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = '/api/v1/users';
const kGetUsersEndpoint = '/api/v1/users';

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Client _client;

  const AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, kCreateUserEndpoint),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
   try {
     final response = await _client.get(Uri.https(kBaseUrl, kGetUsersEndpoint));
     if (response.statusCode != 200) {
       throw APIException(
         message: response.body,
         statusCode: response.statusCode,
       );
     }
     return List<DataMap>.from(jsonDecode(response.body) as List)
         .map((userData) => UserModel.fromMap(userData))
         .toList();
   } on APIException {
     rethrow;
   } catch (e) {
     throw APIException(message: e.toString(), statusCode: 505);
   }
  }
}
