import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/custom_exeption.dart';
import 'package:my_app/data/entity/user/user.entity.dart';

import '../../../../core/constant/error_code.dart';
import '../../../../core/exception/failure.dart';
import '../../../repository/user/user.repository.dart';

part '../../case/user/get_current_user.usecase.dart';

part '../../case/user/upsert_user.usecase.dart';

part '../../case/user/delete_user.usecase.dart';

part '../../case/user/on_boarding.usecase.dart';

@lazySingleton
class UserUseCase {
  final UserRepository _repository;

  UserUseCase(this._repository);

  @injectable
  GetCurrentUserUseCase get getCurrentUser =>
      GetCurrentUserUseCase(_repository);

  @injectable
  UpsertUserUseCase get upsertUser => UpsertUserUseCase(_repository);

  @injectable
  DeleteUserUseCase get deleteUser => DeleteUserUseCase(_repository);

  @injectable
  OnBoardingUseCase get onBoarding => OnBoardingUseCase(_repository);
}
