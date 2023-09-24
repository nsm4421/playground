import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/repository/chat_repository.dart';
import 'package:chat_app/screen/service/chat/f_add_or_edit_chat_room.dart';
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

  /// 맨 아래로 스크롤 하기
  _scrollToBottom(ScrollController sc) => sc.animateTo(
        sc.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

  /// 채팅방 생성 & 수정 화면 띄우기
  showAddOrEditChatRoomFragment(
          {required BuildContext context, String? chatRoomId}) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) =>
            AddOrEditChatRoomFragment(chatRoomId),
      );

  /// 채팅방 입장하기
  goToChatRoom(
          {required BuildContext context, required String chatRoomId}) async =>
      await chatRepository.getChatRoomById(chatRoomId).then((fetched) {
        // 채팅방이 존재하지 않는 경우
        if (fetched == null) {
          AlertUtils.showSnackBar(context, 'Chat Room Not Exist...');
          return;
        }
        // 현재 채팅방으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ChatRoomScreen(
              chatRoomId: chatRoomId,
            ),
          ),
        );
      });

  /// 채팅방 생성하기
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
        AlertUtils.showSnackBar(context, 'Success to create chat room');
        return;
      }
      // 채팅방 만들기 성공 시 → 채팅방으로 이동
      context.pop();
      goToChatRoom(context: context, chatRoomId: chatRoomId);
      return;
    });
  }

  /// 채팅방 수정하기
  editChatRoom({
    required String chatRoomId,
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
    final chatRoomName = chatRoomNameTEC.text.trim();
    final hashtags = hashtagTECList.map((tec) => tec.text.trim()).toList();
    await chatRepository
        .editChatRoom(
      chatRoomId: chatRoomId,
      chatRoomName: chatRoomName,
      hashtags: hashtags,
    )
        .then((isSuccess) {
      if (isSuccess) {
        AlertUtils.showSnackBar(context, 'Success to edit chat room');
        context.pop();
        return;
      }
      AlertUtils.showSnackBar(context, 'Fail to edit chat room');
      return;
    });
  }

  /// 채팅방 삭제하기
  deleteChatRoom({
    required BuildContext context,
    required String chatRoomId,
  }) async =>
      await chatRepository
          .deleteChatRoom(chatRoomId: chatRoomId)
          .then((isSuccess) {
        if (isSuccess) {
          context.pop();
          return;
        }
        AlertUtils.showSnackBar(context, 'Fail to delete chat room');
        return;
      });

  /// 텍스트 메시지 보내기
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

  /// 특정 채팅방에서 메세지 조회하기
  Future<List<MessageModel>> getMessages(
          {required String chatRoomId, ScrollController? sc}) async =>
      await chatRepository.getMessages(chatRoomId: chatRoomId).then((data) {
        if (sc != null) _scrollToBottom(sc);
        return data;
      });
}
