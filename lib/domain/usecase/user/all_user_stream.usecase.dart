import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user/user.repository.dart';

@singleton
class AllUserStream {
  final UserRepository _repository;

  AllUserStream(this._repository);

  ResultEntity<Stream<List<UserEntity>>> call() =>
      ResultEntity.fromResponse(_repository.getAllUserStream());
}
