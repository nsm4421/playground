import '../../../repository/auth/auth.repository.dart';
import '../../base/base.usecase.dart';

class SignInWithEmailAndPasswordUseCase extends BaseUseCase<AuthRepository> {
  final String email;
  final String password;

  SignInWithEmailAndPasswordUseCase({
    required this.email,
    required this.password,
  });

  @override
  Future<void> call(AuthRepository repository) async {}
}
