import 'package:injectable/injectable.dart';

import '../../entity/user/user.entity.dart';
import '../../repository/user/credential.repository.dart';

@singleton
class GoogleSignInUseCase {
  final CredentialRepository _repository;

  GoogleSignInUseCase(this._repository);

  Future<UserEntity> call() async => await _repository.googleSignIn();
}
