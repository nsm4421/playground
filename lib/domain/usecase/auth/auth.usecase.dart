import 'package:hot_place/domain/repository/auth/auth.repository.dart';
import 'package:hot_place/domain/usecase/auth/case/get_auth_stream.usecase.dart';
import 'package:hot_place/domain/usecase/auth/case/sign_in_with_email_and_password.dart';
import 'package:hot_place/domain/usecase/auth/case/sign_out.usecase.dart';
import 'package:hot_place/domain/usecase/auth/case/sign_up_with_email_and_password.usecase.dart';
import 'package:injectable/injectable.dart';

import 'case/get_current_user.usecase.dart';

@lazySingleton
class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  @injectable
  GetAuthStreamUseCase get getAuthStream => GetAuthStreamUseCase(_repository);

  @injectable
  GetCurrentUserUserCase get getCurrentUser =>
      GetCurrentUserUserCase(_repository);

  @injectable
  SignInWithEmailAndPasswordUseCase get signInWithEmailAndPassword =>
      SignInWithEmailAndPasswordUseCase(_repository);

  @injectable
  SignOutUseCase get signOut => SignOutUseCase(_repository);

  @injectable
  SignUpWithEmailAndPasswordUseCase get signUpWithEmailAndPassword =>
      SignUpWithEmailAndPasswordUseCase(_repository);
}
