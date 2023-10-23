import 'package:clean_chat_app/src/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

// Whats does the class depend on?
// Quais são as dependências dessa classe?
// -- AuthenticationRepository
// How can we create a fake version of the dependency?
// Como podemos criar um mock dessas dependências?
// -- Use mocktail
// How do we control what our dependencies do?
// Como podemos controlar o que nossas dependências fazem?
// -- Using the mocktail's APIs

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUpAll(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('should call the [AuthRepo.createUser]', () async {
    // Arrange
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    // Acts
    final result = await usecase(params);

    //Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);
  });
}
