import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/supabase_constant.dart';
import '../../base/base.datasource.dart';
import '../../../model/auth/account.model.dart';

part "auth.datasource_impl.dart";

abstract interface class AuthDataSource implements BaseDataSource {
  User? get currentUser;

  Stream<AuthState> get authStream;

  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  Future<void> insertAccount(AccountModel account);

  Future<User?> updateMetaData({String? nickname, String? profileImage});

  Future<void> updateAccount(
      {required String uid, String? nickname, String? profileImage});

  Future<String> upsertProfileImage(
      {required String uid, required File profileImage});
}
