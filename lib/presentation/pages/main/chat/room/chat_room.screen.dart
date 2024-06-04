part of 'chat_room.page.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen(this._chat, {super.key});

  final ChatEntity _chat;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late Stream<List<ChatMessageEntity>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = context.read<MessageBloc>().messageStream;
  }

  _handleDeleteChat() async {
    context.read<MessageBloc>().add(DeleteChatEvent(widget._chat));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilderWidget<List<ChatMessageEntity>>(
        stream: _stream,
        onSuccessWidgetBuilder: (data) => ListView.builder(
            itemBuilder: (context, index) => MessageItemWidget(data[index])));
  }
}
