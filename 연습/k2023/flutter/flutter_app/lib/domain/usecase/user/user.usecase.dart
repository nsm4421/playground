import 'package:injectable/injectable.dart';
import 'package:my_app/domain/repository/user/user.repository.dart';
import 'package:my_app/domain/usecase/base/remote.usecase.dart';

@singleton
class UserUseCase {
  final UserRepository _userRepository;

  UserUseCase(this._userRepository);

  Future<T> execute<T>({required RemoteUseCase useCase}) async =>
      await useCase(_userRepository);
}
