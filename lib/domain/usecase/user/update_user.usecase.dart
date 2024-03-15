import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user/user.repository.dart';

@singleton
class UpdateUserUseCase {
  final UserRepository _repository;

  UpdateUserUseCase(this._repository);

  Future<ResultEntity<void>> call(UserEntity user) async => await _repository
      .updateUser(user)
      .then((res) => ResultEntity.fromResponse(res));
}
