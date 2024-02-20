import 'package:hot_place/features/user/domain/repository/user.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class SignOutUseCase {
  final UserRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() async => await repository.signOut();
}