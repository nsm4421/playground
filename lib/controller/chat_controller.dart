import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(
    authRepository: authRepository,
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final AuthRepository authRepository;
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.authRepository,
    required this.chatRepository,
    required this.ref,
  });

  _scrollToBottom(ScrollController sc) => sc.animateTo(
        sc.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

  Future<void> sendTextMessage(
          {required BuildContext context,
          required String chatRoomId,
          required TextEditingController tec,
          required ScrollController sc}) async =>
      // save data in server
      await chatRepository
          .sendTextMessage(
        chatRoomId: chatRoomId,
        text: tec.text,
      )
          .then((isSuccess) {
        if (isSuccess) {
          tec.clear();
          _scrollToBottom(sc);
        }
      });

  Future<List<MessageModel>> getMessages(
          {required String chatRoomId, ScrollController? sc}) async =>
      await chatRepository.getMessages(chatRoomId: chatRoomId).then((data) {
        if (sc != null) _scrollToBottom(sc);
        return data;
      });

  Stream<List<MessageModel>> getMessageStream(String chatRoomId) =>
      chatRepository.getMessageStream(chatRoomId);
}
