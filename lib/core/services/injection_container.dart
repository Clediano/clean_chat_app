import 'package:clean_chat_app/src/modules/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_chat_app/src/modules/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/usecases/create_user.dart';
import 'package:clean_chat_app/src/modules/authentication/domain/usecases/get_users.dart';
import 'package:clean_chat_app/src/modules/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App logic
    ..registerFactory(
      () => AuthenticationCubit(createUser: sl(), getUsers: sl()),
    )

    // Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl()),
    )

    // Data sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(sl()),
    )

    // External dep
    ..registerLazySingleton(Client.new);
}
