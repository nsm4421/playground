import 'package:injectable/injectable.dart';

import '../repository/repository_module.dart';
import 'account/usecase.dart';
import 'auth/usecase.dart';
import 'diary/usecase.dart';

@lazySingleton
class UseCaseModule {
  final RepositoryModule _repositoryModule;

  UseCaseModule(this._repositoryModule);

  @lazySingleton
  AuthUseCase get auth => AuthUseCase(_repositoryModule.auth);

  @lazySingleton
  AccountUseCase get account => AccountUseCase(_repositoryModule.account);

  @lazySingleton
  DiaryUseCase get diary => DiaryUseCase(_repositoryModule.diary);
}
