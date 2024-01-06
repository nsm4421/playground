import 'package:injectable/injectable.dart';

import '../../repository/auth/auth.repository.dart';
import '../base.usecase.dart';

@singleton
class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future execute<T>({required BaseUseCase useCase}) async =>
      await useCase(_authRepository);
}
