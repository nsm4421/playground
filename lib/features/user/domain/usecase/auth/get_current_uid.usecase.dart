import 'package:hot_place/features/user/domain/repository/user.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetCurrentUidUseCase {
  final UserRepository repository;

  GetCurrentUidUseCase(this.repository);

  String? call() => repository.currentUid;
}
