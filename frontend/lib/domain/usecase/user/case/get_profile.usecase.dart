import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.constant.dart';
import '../../../../data/entity/user/user.entity.dart';
import '../../../repository/user/user.repository.dart';

class GetProfileUseCase {
  final UserRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(String currentUid) async {
    return await _repository.findUserById(currentUid);
  }
}
