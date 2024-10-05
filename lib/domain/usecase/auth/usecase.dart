import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/response/error_response.dart';
import 'package:travel/domain/entity/auth/presence.dart';
import 'package:travel/domain/repository/auth/repository.dart';

import '../../../core/response/error_code.constant.dart';

part 'scenario/sign_up.dart';

part 'scenario/sign_in.dart';

part 'scenario/sign_out.dart';

part 'scenario/getter.dart';

class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  GetAuthStateStreamUseCase get authStateStream =>
      GetAuthStateStreamUseCase(_repository);

  GetIsAuthorizedUseCase get isAuthorized =>
      GetIsAuthorizedUseCase(_repository);

  GetCurrentUser get currentUser => GetCurrentUser(_repository);

  GetEmailAndPasswordUseCase get getEmailAndPassword =>
      GetEmailAndPasswordUseCase(_repository);

  SignInWithEmailAndPasswordUseCase get signIn =>
      SignInWithEmailAndPasswordUseCase(_repository);

  SignUpWithEmailAndPasswordUseCase get signUp =>
      SignUpWithEmailAndPasswordUseCase(_repository);

  SignOutUseCase get signOut => SignOutUseCase(_repository);
}
