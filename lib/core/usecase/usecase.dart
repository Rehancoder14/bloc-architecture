import 'package:blogclean/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<T, Param> {
  Future<Either<Failures, T>> call(Param params);
}

class NoParams {}
