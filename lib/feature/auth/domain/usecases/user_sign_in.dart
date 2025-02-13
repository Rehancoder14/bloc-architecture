import 'package:blogclean/core/error/failures.dart';
import 'package:blogclean/core/usecase/usecase.dart';
import 'package:blogclean/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';

class UserSignIn implements Usecase<User, UserSignInParams> {
  final AuthRepository repository;
  const UserSignIn({required this.repository});

  @override
  Future<Either<Failures, User>> call(params) async {
    return await repository.login(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
