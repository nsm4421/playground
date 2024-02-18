import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user.repository.dart';

@singleton
class SingleUserStreamUseCase {
  final UserRepository repository;

  SingleUserStreamUseCase({required this.repository});

  Stream<UserEntity> call(String uid) => repository.getUserStream(uid);
}
