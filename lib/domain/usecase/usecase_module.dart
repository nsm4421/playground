import 'package:injectable/injectable.dart';
import 'package:travel/domain/usecase/meeting/usecase.dart';
import 'package:travel/domain/usecase/meeting/usecase.dart';

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

  @lazySingleton
  MeetingUseCase get meeting => MeetingUseCase(_repositoryModule.meeting);
}
