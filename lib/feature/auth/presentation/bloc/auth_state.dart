part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(
    this.user,
  );
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class ShowPassword extends AuthState {
  final bool showPassword;

  ShowPassword(this.showPassword);
}

class AuthLoginSuccess extends AuthState {
  final User user;

  AuthLoginSuccess(this.user);
}

class AuthLoginError extends AuthState {
  final String message;

  AuthLoginError(this.message);
}

class AuthLoginLoading extends AuthState {}
