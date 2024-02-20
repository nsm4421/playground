import 'package:injectable/injectable.dart';

import '../../repository/user.repository.dart';

@singleton
class GetDeviceNumberUseCase {
  final UserRepository repository;

  GetDeviceNumberUseCase(this.repository);

  Future<void> call() async => await repository.getDeviceNumber();
}
