import 'package:injectable/injectable.dart';
import 'package:my_app/domain/usecase/base/remote.usecase.dart';

import '../../repository/auth/auth.repository.dart';

@singleton
class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<T> execute<T>({required RemoteUseCase useCase}) async =>
      await useCase(_authRepository);
}
