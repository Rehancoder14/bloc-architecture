import 'dart:developer';

import 'package:blogclean/core/error/exceptions.dart';
import 'package:blogclean/feature/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  // session
  Session? get currentUserSession;
  // login
  Future<UserModel> login({
    required String email,
    required String password,
  });

  // success
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel?> getUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      AuthResponse authResponse = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      log(authResponse.user.toString());
      log(authResponse.session.toString());
      if (authResponse.user == null) {
        throw ServerException(message: 'User not found');
      }
      return UserModel(
        id: authResponse.user?.id ?? '',
        email: authResponse.user?.email ?? '',
        name: authResponse.user?.email ?? '',
      );
    } catch (e) {
      throw ServerException(message: 'User not found');
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      AuthResponse authResponse = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      if (authResponse.user == null) {
        throw ServerException(message: 'User not created');
      }
      return UserModel.fromJson(
        authResponse.user?.toJson() ?? {},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getUser() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession?.user.id ?? '');

        return UserModel(
          id: currentUserSession?.user.id ?? '',
          email: currentUserSession?.user.email ?? '',
          name: userData.first['name'],
        );
      }
      return null;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }
}
