import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/model/chat_room_model.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/repository/chat_repository.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final List<ChatRoomModel> _chatRoomList = [];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  _goToChatRoom(String? chatRoomId) {
    if (chatRoomId == null) return;
    ref
        .read(chatControllerProvider)
        .goToChatRoom(chatRoomId: chatRoomId, context: context);
  }

  _handleBottomModalSheet() =>
      ref
          .read(chatControllerProvider)
          .showAddOrEditChatRoomFragment(context: context);

  _init() async {
    // 채팅방 목록 가져오기
    final fetched = await ref.read(chatRepositoryProvider).getChatRoomList();
    setState(() {
      _chatRoomList.addAll(fetched);
    });
  }

  /// 채팅방 수정 UI(bottom sheet) 띄우기
  _handleShowEditUI(String chatRoomId) =>
      ref
          .read(chatControllerProvider)
          .showAddOrEditChatRoomFragment(
          context: context, chatRoomId: chatRoomId);

  /// 채팅방 삭제하기
  _handleDeleteChatRoom(String chatRoomId) =>
      ref.read(chatControllerProvider).deleteChatRoom(
        chatRoomId: chatRoomId,
        context: context,
      );

  AppBar _appBar() =>
      AppBar(
        centerTitle: true,
        title: Text(
          "Chats",
          style: GoogleFonts.lobster(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _handleBottomModalSheet,
            icon: const Icon(
              Icons.add_box_outlined,
              size: 30,
            ),
          ),
        ],
      );

  _chatList() =>
      StreamBuilder<List<ChatRoomModel>>(
        initialData: _chatRoomList,
        stream: ref.read(chatRepositoryProvider).getChatRoomStream(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ChatRoomModel>> snapshot) =>
        (snapshot.connectionState == ConnectionState.waiting)
            ? const CircularProgressIndicator()
            : ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
          (snapshot.data?[index] != null
              ? _chatRoomItem(snapshot.data![index])
              : const SizedBox()),
          separatorBuilder: (BuildContext context, int index) =>
          const Divider(),
        ),
      );

  Widget _chatRoomItem(ChatRoomModel item) =>
      ListTile(
        // 프로필 사진
        leading: CircleAvatar(
          child: Container(),
        ),
        tileColor: Colors.grey[100],
        title: Text(
          item.chatRoomName ?? 'Chat Room',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        // 해시태그
        subtitle: Row(
          children: item.hashtags
              .map((hashtag) =>
              Row(
                children: [
                  Text(
                    "# $hashtag",
                    style:
                    const TextStyle(color: Colors.teal, fontSize: 15),
                  ),
                  const Width(5),
                ],
              ))
              .toList(),
        ),
        // 채팅방 수정 및 삭제
        trailing:
        item.host == ref
            .read(authRepositoryProvider)
            .getCurrentUser()
            ?.uid
            ? PopupMenuButton(
          onSelected: (context) {
            context.pop();
          },
          itemBuilder: (BuildContext ctx) =>
          [
            // 수정버튼
            PopupMenuItem(
              child: InkWell(
                onTap: () {
                  _handleShowEditUI(item.chatRoomId!);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 20,
                    ),
                    Width(5),
                    Text(
                      "Edit",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            // 삭제 버튼
            PopupMenuItem(
              child: InkWell(
                onTap: () {
                  _handleDeleteChatRoom(item.chatRoomId!);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete,
                      size: 20,
                    ),
                    Width(5),
                    Text(
                      "Delete",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            : const SizedBox(),
        onTap: () {
          _goToChatRoom(item.chatRoomId);
        },
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [const Height(20), _chatList()],
          ),
        ),
      ),
    );
  }
}
