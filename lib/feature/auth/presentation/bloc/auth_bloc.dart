import 'package:blogclean/core/usecase/usecase.dart';
import 'package:blogclean/feature/auth/domain/usecases/current_user.dart';
import 'package:blogclean/feature/auth/domain/usecases/user_sign_in.dart';
import 'package:blogclean/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _signUp;
  final UserSignIn _login;
  final CurrentUser _currentUser;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserSignIn userSignIn,
      required CurrentUser currentUser})
      : _signUp = userSignUp,
        _login = userSignIn,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoading());
      final response = await _signUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      response.fold((l) {
        emit(AuthError(l.message));
      }, (r) {
        emit(AuthSuccess(r));
      });
    });

    on<ShowPasswordEvent>((event, emit) {
      final currentState = state;
      if (currentState is ShowPassword) {
        emit(ShowPassword(!currentState.showPassword));
      } else {
        emit(ShowPassword(event.showPassword));
      }
    });

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoginLoading());
      final response = await _login(
        UserSignInParams(
          email: event.email,
          password: event.password,
        ),
      );
      response.fold((l) {
        emit(
          AuthError(l.message),
        );
      }, (r) {
        emit(
          AuthSuccess(r),
        );
      });
    });

    on<AuthIsUserLoggedInEvent>((event, emit) async {
      emit(AuthLoginLoading());
      final response = await _currentUser(NoParams());
      response.fold((l) {
        emit(AuthError(l.message));
      }, (r) {
        emit(AuthLoginSuccess(r));
      });
    });
  }
}
