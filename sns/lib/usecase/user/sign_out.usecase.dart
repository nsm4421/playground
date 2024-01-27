
import '../../repository/user/user.repository.dart';
import '../base/remote.usecase.dart';

class SignOutUsecase extends RemoteUsecase<UserRepository> {
  SignOutUsecase();

  @override
  Future<void> call(UserRepository repository) async =>
      await repository.signOut();
}
