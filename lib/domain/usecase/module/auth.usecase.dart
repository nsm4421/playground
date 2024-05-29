import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/exception/failure.dart';
import '../../repository/auth/auth.repository.dart';

part '../case/auth/sign_in_with_google.usecase.dart';

part '../case/auth/sign_out.usecase.dart';

part '../case/auth/get_auth_stream.usecase.dart';

@singleton
class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  @injectable
  GetAuthStreamUseCase get authStream => GetAuthStreamUseCase(_repository);

  @injectable
  SignInWithGoogleUseCase get signInWithGoogle =>
      SignInWithGoogleUseCase(_repository);

  @injectable
  SignOutUseCase get signOut => SignOutUseCase(_repository);
}
