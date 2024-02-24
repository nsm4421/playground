import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user/user.repository.dart';

@singleton
class SingleUserStreamUseCase {
  final UserRepository _repository;

  SingleUserStreamUseCase(this._repository);

  Stream<UserEntity> call(String uid) => _repository.getUserStream(uid);
}
