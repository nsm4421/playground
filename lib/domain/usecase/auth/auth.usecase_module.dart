import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:portfolio/domain/entity/auth/account.entity.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../../data/repository_impl/auth/auth.repository_impl.dart';

part "scenario/edit_profile.usecase.dart";

part "scenario/get_current_user.usecase.dart";

part "scenario/get_auth_stream.usecase.dart";

part 'scenario/sign_up_with_email_and_password.usecase.dart';

part "scenario/sign_in_with_email_and_password.usecase.dart";

part "scenario/sign_out.usecase.dart";

part "scenario/find_by_uid.usecase.dart";

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
  EditProfileUseCase get editProfile => EditProfileUseCase(_repository);

  @injectable
  SignOutUseCase get signOut => SignOutUseCase(_repository);

  @injectable
  FindByUidUseCase get findByUid => FindByUidUseCase(_repository);
}
