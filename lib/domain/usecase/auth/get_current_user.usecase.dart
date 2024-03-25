import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.constant.dart';
import '../../repository/auth/auth.repository.dart';

@lazySingleton
class GetCurrentUserUserCase {
  final AuthRepository _repository;

  GetCurrentUserUserCase(this._repository);

  Either<Failure, UserEntity> call() {
    return _repository.getCurrentUserOrElseThrow();
  }
}
