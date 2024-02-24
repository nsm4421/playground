import 'package:injectable/injectable.dart';

import '../../repository/user/credential.repository.dart';

@singleton
class IsAuthenticatedUseCase {
  final CredentialRepository _repository;

  IsAuthenticatedUseCase(this._repository);

  bool call() => _repository.isAuthenticated;
}
