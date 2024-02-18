import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user.repository.dart';

@singleton
class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  Future<void> call(UserEntity user) async => await repository.updateUser(user);
}
