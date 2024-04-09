import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failure.constant.dart';
import '../../../data/entity/user/user.entity.dart';
import '../../repository/user/user.repository.dart';

@lazySingleton
class ModifyProfileUseCase {
  final UserRepository _repository;

  ModifyProfileUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(
      {required UserEntity currentUser,
      String? nickname,
      String? profileImage}) async {
    final user = currentUser.copyWith(
        nickname: nickname ?? currentUser.nickname,
        profileImage: profileImage ?? currentUser.profileImage);
    return await _repository
        .modifyUser(user)
        .then((res) => res.map((_) => user));
  }
}
