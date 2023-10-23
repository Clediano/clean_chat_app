import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  const User.empty()
      : this(
          id: "1",
          name: '_empty_name',
          avatar: '_empty_avatar',
          createdAt: '_empty_createdAt',
        );

  final String id;
  final String name;
  final String avatar;
  final String createdAt;

  @override
  List<Object?> get props => [id, name, avatar];
}
