import 'package:hot_place/features/user/domain/repository/user.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class IsAuthorizedUseCase {
  final UserRepository repository;

  IsAuthorizedUseCase(this.repository);

  bool call() => repository.isAuthorized;
}
