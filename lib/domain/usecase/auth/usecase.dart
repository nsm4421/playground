part of '../export.usecase.dart';

@lazySingleton
class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  Stream<UserEntity?> get authStream => _repository.authStream;

  GetUserUseCase get getUser => GetUserUseCase(_repository);

  SignUpUseCase get signUp => SignUpUseCase(_repository);

  SignInUseCase get signIn => SignInUseCase(_repository);

  SignOutUseCase get signOut => SignOutUseCase(_repository);

  EditProfileUseCase get editProfile => EditProfileUseCase(_repository);
}
