import 'dart:convert';

import 'package:clean_chat_app/core/utils/typedef.dart';
import 'package:clean_chat_app/src/modules/authentication/data/models/user_model.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test('should be a subclass of [User] entity', () {
    // Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromMap(tMap);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = UserModel.fromJson(tJson);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [DataMap] with the right data', () {
      // Act
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] string with the right data', () {
      // Arrange
      final tJson = jsonEncode({
        "id": "1",
        "avatar": "_empty_avatar",
        "createdAt": "_empty_createdAt",
        "name": "_empty_name"
      });

      // Act
      final result = tModel.toJson();

      // Assert
      expect(result, equals(tJson));
    });
  });
  
  group('copyWith', () {
    test('should return a [UserModel] with the specific attributes', () {
      // Act
      final result = tModel.copyWith(
          name: 'Arturo Wintheiser',
          id: '2',
          createdAt: '2023-10-18T09:37:56.088Z',
          avatar: 'https://cloudflare-ipfs.com/avatar/1211.jpg',
      );

      // Assert
      expect(result.id, "2");
      expect(result.name, "Arturo Wintheiser");
      expect(result.createdAt, "2023-10-18T09:37:56.088Z");
      expect(result.avatar, "https://cloudflare-ipfs.com/avatar/1211.jpg");
    });
  });
}
