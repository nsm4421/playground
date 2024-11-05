import 'package:injectable/injectable.dart';
import '../repository/repository.dart';
import 'auth/usecase.dart';

@lazySingleton
class UseCaseModule {
  final AuthRepository _authRepository;

  UseCaseModule({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @lazySingleton
  AuthUseCase get auth => AuthUseCase(_authRepository);
}
