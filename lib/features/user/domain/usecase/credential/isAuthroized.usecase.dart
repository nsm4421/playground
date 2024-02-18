import 'package:hot_place/features/user/domain/repository/user.repository.dart';

class IsAuthorizedUseCase {
  final UserRepository repository;

  IsAuthorizedUseCase(this.repository);

  Future<bool> call() async => repository.isAuthorized();
}