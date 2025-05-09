part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({
    required this.email,
    required this.password,
  });
}

final class ShowPasswordEvent extends AuthEvent {
  final bool showPassword;

  ShowPasswordEvent(this.showPassword);
}

class AuthIsUserLoggedInEvent extends AuthEvent {}
