import 'package:clean_chat_app/src/modules/authentication/domain/entities/user.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/usecases/get_users.dart';
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
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUpAll(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty(), User.empty()];

  test('should call the [AuthRepo.getUsers] and return [List<User>]', () async {
    // Arrange
    when(() => repository.getUsers())
        .thenAnswer((_) async => const Right(tResponse));

    // Acts
    final result = await usecase();

    //Assert
    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
