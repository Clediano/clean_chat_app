import 'package:clean_chat_app/core/usecase/usecase.dart';
import 'package:clean_chat_app/core/utils/typedef.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture call(CreateUserParams params) async {
    return _repository.createUser(
      createdAt: params.createdAt,
      name: params.name,
      avatar: params.avatar,
    );
  }
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty()
      : this(
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
