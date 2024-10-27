import 'package:injectable/injectable.dart';
import '../repository/repository_module.dart';
import 'account/usecase.dart';
import 'auth/usecase.dart';
import 'comment/usecase.dart';
import 'diary/usecase.dart';
import 'like/usecase.dart';
import 'meeting/usecase.dart';
import 'registration/usecase.dart';

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

  @lazySingleton
  RegistrationUseCase get registration =>
      RegistrationUseCase(_repositoryModule.registration);

  @lazySingleton
  CommentUseCase get comment => CommentUseCase(_repositoryModule.comment);

  @lazySingleton
  LikeUseCase get like => LikeUseCase(_repositoryModule.like);
}
