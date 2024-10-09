import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/data/model/auth/auth_user.model.dart';

part 'mock_datasource.dart';

part 'datasource_impl.dart';

abstract interface class AuthDataSource {
  Stream<AuthUserModel?> get authStateStream;

  String? get currentUid;

  AuthUserModel? get authUser;

  bool get isAuthorized;

  Future<AuthUserModel?> editProfile({String? username, String? avatarUrl});

  Future<AuthUserModel?> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String avatarUrl});

  Future<AuthUserModel?> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();
}
