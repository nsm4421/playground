import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/repository/chat_repository.dart';
import 'package:chat_app/screen/service/chat/f_add_chat_room.dart';
import 'package:chat_app/screen/service/chat/s_chat_room.dart';
import 'package:chat_app/utils/alert_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  showAddChatRoomFragment({required BuildContext context}) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => const AddChatRoomFragment(),
      );

  goToChatRoom({required BuildContext context, required String chatRoomId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => ChatRoomScreen(chatRoomId: chatRoomId)),
    );
  }

  createChatRoom({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController chatRoomNameTEC,
    required List<TextEditingController> hashtagTECList,
  }) async {
    // field값 검사하기
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    // 채팅방 정보 저장
    await chatRepository
        .createChatRoom(
      chatRoomName: chatRoomNameTEC.text.trim(),
      hashtags: hashtagTECList.map((tec) => tec.text.trim()).toList(),
    )
        .then((chatRoomId) {
      // 채팅방 만들기 실패
      if (chatRoomId == null) {
        context.pop();
        AlertUtils.showSnackBar(context, 'Success to create room');
        return;
      }
      // 채팅방 만들기 성공 시 → 채팅방으로 이동
      context.pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatRoomScreen(chatRoomId: chatRoomId),
        ),
      );
      return;
    });
  }

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
}
