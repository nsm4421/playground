import 'package:injectable/injectable.dart';
import 'package:travel/data/repository_impl/repository_impl.dart';
import 'package:travel/domain/usecase/feed/usecase.dart';
import '../repository/repository.dart';
import 'auth/usecase.dart';

@lazySingleton
class UseCaseModule {
  final AuthRepository _authRepository;
  final FeedRepository _feedRepository;

  UseCaseModule({
    required AuthRepository authRepository,
    required FeedRepository feedRepository,
  })  : _authRepository = authRepository,
        _feedRepository = feedRepository;

  @lazySingleton
  AuthUseCase get auth => AuthUseCase(_authRepository);

  @lazySingleton
  FeedUseCase get feed => FeedUseCase(_feedRepository);
}
