import 'package:hot_place/domain/repository/user/credential.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetCurrentUidUseCase {
  final CredentialRepository repository;

  GetCurrentUidUseCase(this.repository);

  String? call() => repository.currentUid;
}
