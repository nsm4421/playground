import '../../../core/enums/response_status.enum.dart';
import '../../../core/response/error_response.dart';
import '../../../core/response/result.dart';
import '../../repository/auth/auth.repository.dart';
import '../base/remote.usecase.dart';

class SignInWithEmailAndPasswordUseCase extends RemoteUseCase<AuthRepository> {
  final String email;
  final String password;

  SignInWithEmailAndPasswordUseCase(
      {required this.email, required this.password});

  @override
  Future call(AuthRepository repository) async {
    final res = await repository.signInWithEmailAndPassword(
        email: email, password: password);
    switch (res.status) {
      case ResponseStatus.success:
        return Result<String>.success(email);
      default:
        return Result<String>.failure(ErrorResponse.fromResponseWrapper(res));
    }
  }
}
