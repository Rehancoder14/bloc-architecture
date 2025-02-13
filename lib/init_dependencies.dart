import 'package:blogclean/core/secrets/app_secrets.dart';
import 'package:blogclean/feature/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blogclean/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:blogclean/feature/auth/domain/repository/auth_repository.dart';
import 'package:blogclean/feature/auth/domain/usecases/current_user.dart';
import 'package:blogclean/feature/auth/domain/usecases/user_sign_in.dart';
import 'package:blogclean/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:blogclean/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignIn(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CurrentUser(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      currentUser: serviceLocator(),
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
    ),
  );
}
