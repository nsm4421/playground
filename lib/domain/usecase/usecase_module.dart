import 'package:injectable/injectable.dart';
import 'package:travel/domain/repository/repository_module.dart';
import 'package:travel/domain/usecase/auth/usecase.dart';
import 'package:travel/domain/usecase/diary/usecase.dart';

import 'account/usecase.dart';

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
