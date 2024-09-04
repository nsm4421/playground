import 'dart:io';

import 'package:flutter_app/auth/data/repository/repository_impl.dart';
import 'package:injectable/injectable.dart';

part 'scenario/sign_up_with_email_and_password.dart';
part 'scenario/sign_in_with_email_and_password.dart';
part 'scenario/check_username.dart';

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
}
