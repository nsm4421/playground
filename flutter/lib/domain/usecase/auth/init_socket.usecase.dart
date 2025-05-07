part of '../export.usecase.dart';

class InitSocketUseCase {
  final AuthRepository _authRepository;
  final GroupChatRepository _groupChatRepository;

  final PrivateChatRepository _privateChatRepository;

  InitSocketUseCase(
      {required AuthRepository authRepository,
      required GroupChatRepository groupChatRepository,
      required PrivateChatRepository privateChatRepository})
      : _authRepository = authRepository,
        _groupChatRepository = groupChatRepository,
        _privateChatRepository = privateChatRepository;

  void call() {
    _authRepository.initSocket();
    _groupChatRepository.init();
    _privateChatRepository.init();
  }
}
