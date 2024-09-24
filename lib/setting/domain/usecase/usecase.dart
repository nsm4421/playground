import 'dart:developer';
import 'dart:io';

import 'package:flutter_app/setting/data/repository/repository_impl.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/shared.export.dart';

part 'scenario/check_username.dart';

part 'scenario/edit_profile.dart';

@lazySingleton
class AccountUseCase {
  final AccountRepository _repository;

  AccountUseCase(this._repository);

  CheckUsernameUseCase get checkUsername => CheckUsernameUseCase(_repository);

  EditProfileUseCase get editProfile => EditProfileUseCase(_repository);
}
