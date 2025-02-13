import 'package:blogclean/core/error/failures.dart';
import 'package:blogclean/core/usecase/usecase.dart';
import 'package:blogclean/feature/auth/domain/entities/user.dart';
import 'package:blogclean/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository repository;
  const CurrentUser({required this.repository});

  @override
  Future<Either<Failures, User>> call(NoParams param) async {
    return await repository.getUser();
  }
}
