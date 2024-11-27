import 'package:injectable/injectable.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/domain/repository/repository.dart';
import 'package:travel/domain/usecase/auth/usecase.dart';
import 'package:travel/domain/usecase/chat/private/usecase.dart';
import 'package:travel/domain/usecase/comment/usecase.dart';
import 'package:travel/domain/usecase/emotion/usecase.dart';
import 'package:travel/domain/usecase/feed/usecase.dart';
import 'package:travel/domain/usecase/reels/usecase.dart';

@lazySingleton
class UseCaseModule {
  final AuthRepository _authRepository;
  final FeedRepository _feedRepository;
  final ReelsRepository _reelsRepository;
  final EmotionRepository _emotionRepository;
  final CommentRepository _commentRepository;
  final PrivateChatRepository _privateChatRepository;
  final PrivateMessageRepository _privateMessageRepository;

  UseCaseModule({
    required AuthRepository authRepository,
    required FeedRepository feedRepository,
    required ReelsRepository reelsRepository,
    required EmotionRepository emotionRepository,
    required CommentRepository commentRepository,
    required PrivateChatRepository privateChatRepository,
    required PrivateMessageRepository privateMessageRepository,
  })  : _authRepository = authRepository,
        _feedRepository = feedRepository,
        _reelsRepository = reelsRepository,
        _emotionRepository = emotionRepository,
        _commentRepository = commentRepository,
        _privateChatRepository = privateChatRepository,
        _privateMessageRepository = privateMessageRepository;

  @lazySingleton
  AuthUseCase get auth => AuthUseCase(_authRepository);

  @lazySingleton
  FeedUseCase get feed => FeedUseCase(_feedRepository);

  @lazySingleton
  ReelsUseCase get reels => ReelsUseCase(_reelsRepository);

  @lazySingleton
  EmotionUseCase get emotion => EmotionUseCase(_emotionRepository);

  @lazySingleton
  CommentUseCase get comment => CommentUseCase(_commentRepository);

  @lazySingleton
  PrivateChatUseCase get privateChat => PrivateChatUseCase(
      chatRepository: _privateChatRepository,
      messageRepository: _privateMessageRepository);
}
