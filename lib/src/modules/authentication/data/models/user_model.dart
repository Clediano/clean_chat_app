import 'dart:convert';

import 'package:clean_chat_app/core/utils/typedef.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.createdAt,
  });

  const UserModel.empty()
      : this(
    id: "1",
    name: '_empty_name',
    avatar: '_empty_avatar',
    createdAt: '_empty_createdAt',
  );

  factory UserModel.fromJson(String source) {
    return UserModel.fromMap(jsonDecode(source) as DataMap);
  }

  UserModel copyWith({
    String? avatar,
    String? id,
    String? createdAt,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  UserModel.fromMap(DataMap map)
      : this(
          avatar: map['avatar'] as String,
          createdAt: map['createdAt'] as String,
          id: map['id'] as String,
          name: map['name'] as String,
        );

  DataMap toMap() =>
      {'id': id, 'avatar': avatar, 'createdAt': createdAt, 'name': name};

  String toJson() => jsonEncode(toMap());
}
