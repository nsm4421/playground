import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/util/util.dart';
import 'package:travel/data/datasource/auth/datasource.dart';
import 'package:travel/data/datasource/local/datasource.dart';
import 'package:travel/data/datasource/storage/datasource.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constant/constant.dart';
import '../../../core/response/error_response.dart';
import '../../entity/auth/presence.dart';

part 'repository_impl.dart';

abstract interface class AuthRepository {
  Future<Map<String, String?>> getEmailAndPassword();

  Stream<PresenceEntity?> get authStateStream;

  PresenceEntity? get currentUser;

  bool get isAuthorized;

  Future<Either<ErrorResponse, PresenceEntity?>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required File profileImage});

  Future<Either<ErrorResponse, PresenceEntity?>> signInWithEmailAndPassword(
      String email, String password);

  Future<Either<ErrorResponse, void>> signOut();
}
