import 'package:injectable/injectable.dart';

import '../../repository/auth.repository.dart';
import '../base/remote.usecase.dart';

@singleton
class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future execute<T>({required RemoteUseCase useCase}) async =>
      await useCase(_authRepository);
}
