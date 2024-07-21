import 'package:injectable/injectable.dart';
import 'package:portfolio/core/constant/response_wrapper.dart';
import 'package:portfolio/features/auth/data/repository_impl/auth.repository_impl.dart';
import 'package:portfolio/features/auth/domain/entity/account.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part "auth.usecase.dart";

@lazySingleton
class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  @injectable
  GetCurrentUserUseCase get currentUser => GetCurrentUserUseCase(_repository);

  @injectable
  GetAuthStreamUseCase get authStream => GetAuthStreamUseCase(_repository);

  @injectable
  SignUpWithEmailAndPasswordUseCase get signUpWithEmailAndPassword =>
      SignUpWithEmailAndPasswordUseCase(_repository);

  @injectable
  SignInWithEmailAndPasswordUseCase get signInWithEmailAndPassword =>
      SignInWithEmailAndPasswordUseCase(_repository);

  @injectable
  EditProfileUseCase get editProfile =>
      EditProfileUseCase(_repository);

  @injectable
  SignOutUseCase get signOut => SignOutUseCase(_repository);
}
