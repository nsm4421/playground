import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';

import '../../repository/user.repository.dart';

class SingleUserStreamUseCase {
  final UserRepository repository;
  final String uid;

  SingleUserStreamUseCase({required this.repository, required this.uid});

  Stream<UserEntity> call() => repository.getUserStream(uid);
}
