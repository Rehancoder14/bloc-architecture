import 'package:blogclean/core/error/failures.dart';
import 'package:blogclean/feature/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blogclean/feature/auth/data/models/user_model.dart';
import 'package:blogclean/feature/auth/domain/entities/user.dart';
import 'package:blogclean/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failures, UserModel>> login(
      {required String email, required String password}) async {
    try {
      final result = await authRemoteDataSource.login(
        email: email,
        password: password,
      );

      return right(
        result,
      );
    } catch (e) {
      return left(
        Failures(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, UserModel>> register(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final result = await authRemoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );

      return right(
        result,
      );
    } catch (e) {
      return left(
        Failures(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, User>> getUser() async {
    try {
      final result = await authRemoteDataSource.getUser();

      if (result == null) {
        throw Exception('User not found');
      }
      return right(
        result,
      );
    } catch (e) {
      return left(
        Failures(
          e.toString(),
        ),
      );
    }
  }
}
