import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/custom_exception.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/error_code.dart';
import '../../../../core/exception/failure.dart';
import '../../../../data/repository_impl/user/account.repository_impl.dart';

part '../../case/user/base/get_current_user.usecase.dart';

part '../../case/user/base/upsert_user.usecase.dart';

part '../../case/user/base/delete_user.usecase.dart';

part '../../case/user/base/on_boarding.usecase.dart';

@lazySingleton
class UserUseCase {
  final AccountRepository _repository;

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
