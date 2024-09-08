import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/shared.export.dart';
import '../../data/data.export.dart';

part 'scenario/sign_up_with_email_and_password.dart';

part 'scenario/sign_in_with_email_and_password.dart';

part 'scenario/check_username.dart';

part 'scenario/sign_out.dart';

@lazySingleton
class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  SignUpWithEmailAndPasswordUseCase get signUpWithEmailAndPassword =>
      SignUpWithEmailAndPasswordUseCase(_authRepository);

  SignInWithEmailAndPasswordUseCase get signInWithEmailAndPassword =>
      SignInWithEmailAndPasswordUseCase(_authRepository);

  CheckUsernameUseCase get checkUsername =>
      CheckUsernameUseCase(_authRepository);

  SignOutUseCase get signOut => SignOutUseCase(_authRepository);

  Stream<User?> get userStream => _authRepository.userStream;

  User? get currentUser => _authRepository.currentUser;
}
