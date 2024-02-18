import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';

import '../../repository/user.repository.dart';

class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  Future<void> call(UserEntity user) async => repository.updateUser(user);
}
