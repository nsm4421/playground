import '../../repository/user.repository.dart';

class GetDeviceNumberUseCase {
  final UserRepository repository;

  GetDeviceNumberUseCase(this.repository);

  Future<void> call() async => await repository.getDeviceNumber();
}
