import 'package:hot_place/features/user/domain/repository/credential.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetCurrentUidUseCase {
  final CredentialRepository repository;

  GetCurrentUidUseCase(this.repository);

  String? call() => repository.currentUid;
}
