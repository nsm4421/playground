import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/constant/user.constant.dart';

import '../../../../core/error/failure.constant.dart';
import '../../../../data/entity/user/user.entity.dart';
import '../../../repository/user/user.repository.dart';

class SearchUsersUseCase {
  final UserRepository _repository;

  SearchUsersUseCase(this._repository);

  Future<Either<Failure, List<UserEntity>>> call({
    required UserSearchType type,
    required String keyword,
  }) async {
    switch (type) {
      case UserSearchType.nickname:
        return await _repository.searchUserByNickname(nickname: keyword);
      case UserSearchType.hashtag:
        return await _repository.searchUserByHashtag(hashtag: keyword);
    }
  }
}
