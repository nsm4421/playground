import 'package:hot_place/domain/repository/auth/auth.repository.dart';
import 'package:hot_place/domain/usecase/base/base.usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<T> execute<T>({required BaseUseCase baseUseCase}) async {
    return await baseUseCase(_authRepository);
  }
}
