import 'package:chat_app/controller/auth_controller.dart';
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
  String? _chatRoomName;

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

  /// init
  _init() async {
    // 메세지 가져오기
    _messages.addAll(
      await ref.read(chatControllerProvider).getMessages(
            chatRoomId: widget.chatRoomId,
            sc: _sc,
          ),
    );
    // 채팅방 제목 설정하기
    _chatRoomName = (await ref
            .read(chatRepositoryProvider)
            .getChatRoomById(widget.chatRoomId))
        ?.chatRoomName;
    setState(() {});
  }

  /// Text 메세지 보내기
  _handleSendTextMessage() {
    if (_messageTEC.text.trim().isEmpty) return;
    ref.read(chatControllerProvider).sendTextMessage(
        context: context,
        chatRoomId: widget.chatRoomId,
        tec: _messageTEC,
        sc: _sc);
  }

  AppBar _appBar() => AppBar(
        centerTitle: true,
        title: Text(
          _chatRoomName ?? '',
          style: GoogleFonts.lobsterTwo(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      );

  Widget _textField() {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: _handleSendTextMessage,
          icon: const Icon(
            Icons.send,
          ),
        ),
      ),
      controller: _messageTEC,
      maxLines: 1,
    );
  }

  Widget _messageList() {
    final uid = ref.read(authRepositoryProvider).getCurrentUser()?.uid;
    if (uid == null) return const Text("ERROR:NEED TO LOGIN");
    return Padding(
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
                                data: snapshot.data![index],
                                myUid: uid,
                              )
                            : const SizedBox()),
                  ),
      ),
    );
  }

  Widget _messageItem({required MessageModel data, required String myUid}) =>
      MessageCardWidget(message: data, isMyMessage: data.senderUid == myUid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _sc,
              child: Column(
                children: [
                  _messageList(),
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
