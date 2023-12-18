import 'package:injectable/injectable.dart';

import '../../repository/auth/auth.repository.dart';
import '../base/remote.usecase.dart';

@singleton
class AuthUsecase {
  final AuthRepository _authRepository;

  AuthUsecase(this._authRepository);

  Future execute<T>({required RemoteUsecase useCase}) async =>
      await useCase(_authRepository);
}
