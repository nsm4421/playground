import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user/credential.repository.dart';

@singleton
class SignOutUseCase {
  final CredentialRepository _repository;

  SignOutUseCase(this._repository);

  Future<ResultEntity<void>> call() async =>
      await _repository.signOut().then(ResultEntity<void>.fromResponse);
}
