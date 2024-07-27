import 'dart:io';

import 'package:portfolio/features/main/core/constant/supabase_constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../main/data/datasource/base.datasource.dart';
import '../model/account.model.dart';

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
