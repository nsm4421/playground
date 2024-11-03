import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/error/error_response.dart';
import '../entity/auth/presence.dart';
import '../repository/repository.dart';

part 'auth/sign_in.dart';

part 'auth/sign_up.dart';

@lazySingleton
class UseCaseModule {
  final AuthRepository _authRepository;

  UseCaseModule({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @lazySingleton
  SignUpWithEmailAndPasswordUseCase get signUp =>
      SignUpWithEmailAndPasswordUseCase(_authRepository);

  @lazySingleton
  SignInWithEmailAndPasswordUseCase get signIn =>
      SignInWithEmailAndPasswordUseCase(_authRepository);
}
