import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exception/failure.dart';
import '../../../../data/repository_impl/user/auth.repository_impl.dart';

part '../../case/user/auth/sign_in_with_google.usecase.dart';

part '../../case/user/auth/sign_up_with_email_and_password.usecase.dart';

part '../../case/user/auth/sign_in_with_email_and_password.usecase.dart';

part '../../case/user/auth/sign_out.usecase.dart';

part '../../case/user/auth/get_auth_stream.usecase.dart';

part '../../case/user/auth/get_current_user.usecase.dart';

@singleton
class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  @injectable
  GetCurrentUserUseCase get currentUser => GetCurrentUserUseCase(_repository);

  @injectable
  GetAuthStreamUseCase get authStream => GetAuthStreamUseCase(_repository);

  @injectable
  SignInWithGoogleUseCase get signInWithGoogle =>
      SignInWithGoogleUseCase(_repository);

  @injectable
  SignInWithEmailAndPasswordUseCase get signInWithEmailAndPassword =>
      SignInWithEmailAndPasswordUseCase(_repository);

  @injectable
  SignUpWithEmailAndPasswordUseCase get signUpWithEmailAndPassword =>
      SignUpWithEmailAndPasswordUseCase(_repository);

  @injectable
  SignOutUseCase get signOut => SignOutUseCase(_repository);
}
