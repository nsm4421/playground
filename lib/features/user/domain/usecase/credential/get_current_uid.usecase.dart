import 'package:hot_place/features/user/domain/repository/user.repository.dart';

class GetCurrentUidUseCase {
  final UserRepository repository;

  GetCurrentUidUseCase(this.repository);

  String? call() => repository.currentUid;
}
