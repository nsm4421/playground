import '../../repository/auth/auth.repository.dart';
import '../base/remote.usecase.dart';

class SignOutUseCase extends RemoteUseCase<AuthRepository> {
  SignOutUseCase();

  @override
  Future call(AuthRepository repository) async => await repository.signOut();
}
