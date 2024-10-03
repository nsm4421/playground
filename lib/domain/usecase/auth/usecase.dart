import 'package:injectable/injectable.dart';
import 'package:travel/core/response/response_wrapper.dart';
import 'package:travel/domain/entity/auth/presence.dart';
import 'package:travel/domain/repository/auth/repository.dart';

part 'scenario/sign_up.dart';

part 'scenario/sign_in.dart';

part 'scenario/sign_out.dart';

part 'scenario/getter.dart';

@lazySingleton
class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  GetAuthStateStreamUseCase get authStateStream =>
      GetAuthStateStreamUseCase(_repository);

  GetIsAuthorizedUseCase get isAuthorized =>
      GetIsAuthorizedUseCase(_repository);

  GetCurrentUser get currentUser => GetCurrentUser(_repository);

  SignInWithEmailAndPasswordUseCase get signIn =>
      SignInWithEmailAndPasswordUseCase(_repository);

  SignUpWithEmailAndPasswordUseCase get signUp =>
      SignUpWithEmailAndPasswordUseCase(_repository);

  SignOutUseCase get signOut => SignOutUseCase(_repository);
}
