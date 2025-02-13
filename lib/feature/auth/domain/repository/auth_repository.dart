import 'package:blogclean/core/error/failures.dart';
import 'package:blogclean/feature/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  // login
  Future<Either<Failures, User>> login({
    required String email,
    required String password,
  });
  // success
  Future<Either<Failures, User>> register({
    required String name,
    required String email,
    required String password,
  });

  // current User
  Future<Either<Failures, User>> getUser();
}
