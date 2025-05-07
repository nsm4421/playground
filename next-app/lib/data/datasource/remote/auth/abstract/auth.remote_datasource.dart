import 'dart:io';

import 'package:logger/logger.dart';
import 'package:portfolio/core/util/exception.util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/supabase_constant.dart';
import '../../../../model/auth/account.model.dart';
import '../../../base/remote_datasource.dart';

part "../impl/auth.remote_datasource_impl.dart";

abstract interface class AuthRemoteDataSource
    implements BaseRemoteDataSource<AccountModel> {
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

  Future<AccountModel> findByUid(String uid);

  Future<int> countByField({required String field, required String value});
}
