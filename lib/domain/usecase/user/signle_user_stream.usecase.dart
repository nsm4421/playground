import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user/user.repository.dart';

@singleton
class SingleUserStreamUseCase {
  final UserRepository repository;

  SingleUserStreamUseCase({required this.repository});

  Stream<UserEntity> call(String uid) => repository.getUserStream(uid);
}
