import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.constant.dart';
import '../../../repository/user/user.repository.dart';

class UpdateLastSeenAtUseCase {
  final UserRepository _repository;

  UpdateLastSeenAtUseCase(this._repository);

  Future<Either<Failure, DateTime>> call() async =>
      await _repository.updateLastSeenAt();
}
