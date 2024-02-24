import 'package:injectable/injectable.dart';

import '../../repository/credential.repository.dart';

@singleton
class IsAuthenticatedUseCase {
  final CredentialRepository repository;

  IsAuthenticatedUseCase(this.repository);

  bool call() => repository.isAuthenticated;
}
