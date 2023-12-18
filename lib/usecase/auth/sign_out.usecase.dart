
import '../../repository/auth/auth.repository.dart';
import '../base/remote.usecase.dart';

class SignOutUsecase extends RemoteUsecase<AuthRepository> {
  SignOutUsecase();

  @override
  Future<void> call(AuthRepository repository) async =>
      await repository.signOut();
}
