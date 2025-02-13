import 'package:blogclean/core/error/failures.dart';
import 'package:blogclean/core/usecase/usecase.dart';
import 'package:blogclean/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository repository;

  UserSignUp(this.repository);

  @override
  Future<Either<Failures, User>> call(UserSignUpParams params) async {
    return await repository.register(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
