import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:injectable/injectable.dart';

import '../../entity/user/user.entity.dart';
import '../../repository/user/credential.repository.dart';

@singleton
class GoogleSignInUseCase {
  final CredentialRepository _repository;

  GoogleSignInUseCase(this._repository);

  Future<ResultEntity<UserEntity>> call() async =>
      await _repository.googleSignIn().then(ResultEntity.fromResponse);
}
