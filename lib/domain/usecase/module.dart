import 'package:injectable/injectable.dart';
import 'package:travel/domain/usecase/feed/usecase.dart';
import 'package:travel/domain/usecase/reels/usecase.dart';
import '../repository/repository.dart';
import 'auth/usecase.dart';

@lazySingleton
class UseCaseModule {
  final AuthRepository _authRepository;
  final FeedRepository _feedRepository;
  final ReelsRepository _reelsRepository;

  UseCaseModule(
      {required AuthRepository authRepository,
      required FeedRepository feedRepository,
      required ReelsRepository reelsRepository})
      : _authRepository = authRepository,
        _feedRepository = feedRepository,
        _reelsRepository = reelsRepository;

  @lazySingleton
  AuthUseCase get auth => AuthUseCase(_authRepository);

  @lazySingleton
  FeedUseCase get feed => FeedUseCase(_feedRepository);

  @lazySingleton
  ReelsUseCase get reels => ReelsUseCase(_reelsRepository);
}
