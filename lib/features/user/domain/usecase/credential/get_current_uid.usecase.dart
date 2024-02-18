import 'package:hot_place/features/user/domain/repository/user.repository.dart';

class GetCurrentUidUseCase {
  final UserRepository repository;

  GetCurrentUidUseCase(this.repository);

  Future<String> call() async => repository.getCurrentUid();
}