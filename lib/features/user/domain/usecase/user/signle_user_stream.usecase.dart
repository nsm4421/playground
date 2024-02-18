import '../../repository/user.repository.dart';

class SingleUserStreamUseCase {
  final UserRepository repository;

  SingleUserStreamUseCase(this.repository);

  Future<void> call() async => repository.singleUserStream();
}
