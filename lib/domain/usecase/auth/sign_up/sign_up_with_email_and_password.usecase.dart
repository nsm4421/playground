import 'package:hot_place/domain/repository/auth/auth.repository.dart';
import 'package:hot_place/domain/usecase/base/base.usecase.dart';

class SignUpWithEmailAndPassword extends BaseUseCase<AuthRepository> {
  final String email;
  final String password;
  final String nickname;

  SignUpWithEmailAndPassword({
    required this.email,
    required this.password,
    required this.nickname,
  });

  @override
  Future<void> call(AuthRepository repository) async {}
}
