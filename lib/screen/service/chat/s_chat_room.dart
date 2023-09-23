import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/model/message_model.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:chat_app/repository/chat_repository.dart';
import 'package:chat_app/screen/widget/w_message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  const ChatRoomScreen({super.key, required this.chatRoomId});

  final String chatRoomId;

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  late TextEditingController _messageTEC;
  late ScrollController _sc;
  final List<MessageModel> _messages = [];
  String chatRoomName = '';

  @override
  void initState() {
    super.initState();
    _messageTEC = TextEditingController();
    _sc = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messageTEC.dispose();
    _sc.dispose();
  }

  _init() async {
    // 채팅방 이름 설정하기
    chatRoomName = await ref
            .read(chatRepositoryProvider)
            .getChatRoomById(widget.chatRoomId)
            .then((value) => value?.chatRoomName) ??
        'Chat Room';
    // 메세지 가져오기
    _messages.addAll(
      await ref.read(chatControllerProvider).getMessages(
            chatRoomId: widget.chatRoomId,
            sc: _sc,
          ),
    );
    setState(() {});
  }

  _handleSendMessage() {
    if (_messageTEC.text.trim().isEmpty) return;
    ref.watch(chatControllerProvider).sendTextMessage(
        context: context,
        chatRoomId: widget.chatRoomId,
        tec: _messageTEC,
        sc: _sc);
  }

  Widget _textField() {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: _handleSendMessage,
          icon: const Icon(
            Icons.send,
          ),
        ),
      ),
      controller: _messageTEC,
      maxLines: 1,
    );
  }

  Widget _messageList(String myUid) => Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<List<MessageModel>>(
          initialData: _messages,
          stream: ref
              .read(chatRepositoryProvider)
              .getMessageStream(widget.chatRoomId),
          builder: (BuildContext context,
                  AsyncSnapshot<List<MessageModel>> snapshot) =>
              (snapshot.connectionState == ConnectionState.waiting)
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) =>
                          (snapshot.data?[index] != null
                              ? _messageItem(
                                  data: snapshot.data![index], myUid: myUid)
                              : const SizedBox()),
                    ),
        ),
      );

  Widget _messageItem({required MessageModel data, required String myUid}) =>
      MessageCardWidget(message: data, isMyMessage: data.senderUid == myUid);

  @override
  Widget build(BuildContext context) {
    final myUid = ref.read(authRepositoryProvider).getCurrentUser()?.uid;

    // TODO : 에러처리
    if (myUid == null) return const Text("ERROR");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // TODO : 채팅방 이름
        title: Text(
          chatRoomName,
          style: GoogleFonts.lobsterTwo(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _sc,
              child: Column(
                children: [
                  _messageList(myUid),
                ],
              ),
            ),
          ),
          _textField(),
        ],
      ),
    );
  }
}
