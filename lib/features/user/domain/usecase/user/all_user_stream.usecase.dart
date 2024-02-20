import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user.repository.dart';

@singleton
class AllUserStream {
  final UserRepository repository;

  AllUserStream(this.repository);

  Stream<List<UserEntity>> call() => repository.allUserStream;
}
