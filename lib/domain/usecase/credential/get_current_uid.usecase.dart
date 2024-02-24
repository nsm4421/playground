import 'package:hot_place/domain/repository/user/credential.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetCurrentUidUseCase {
  final CredentialRepository _repository;

  GetCurrentUidUseCase(this._repository);

  String? call() => _repository.currentUid;
}
