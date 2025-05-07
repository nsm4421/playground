import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/error/error_response.dart';
import '../../entity/auth/presence.dart';
import '../../repository/repository.dart';

part 'sign_in.dart';

part 'sign_up.dart';

part 'sign_out.dart';

part 'edit.dart';

@lazySingleton
class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  @lazySingleton
  PresenceEntity? get currentUser => _authRepository.currentUser;

  @lazySingleton
  Stream<PresenceEntity?> get authStateStream =>
      _authRepository.authStateStream;

  @lazySingleton
  SignUpWithEmailAndPasswordUseCase get signUp =>
      SignUpWithEmailAndPasswordUseCase(_authRepository);

  @lazySingleton
  SignInWithEmailAndPasswordUseCase get signIn =>
      SignInWithEmailAndPasswordUseCase(_authRepository);

  @lazySingleton
  EditProfileUseCase get editProfile => EditProfileUseCase(_authRepository);

  @lazySingleton
  SignOutUseCase get signOut => SignOutUseCase(_authRepository);
}
