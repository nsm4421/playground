part of 'open_chat_room.page.dart';

class OpenChatRoomScreen extends StatefulWidget {
  const OpenChatRoomScreen(this._chat, {super.key});

  final OpenChatEntity _chat;

  @override
  State<OpenChatRoomScreen> createState() => _OpenChatRoomScreenState();
}

class _OpenChatRoomScreenState extends State<OpenChatRoomScreen> {
  List<OpenChatMessageEntity> _messages = [];
  late RealtimeChannel _messageChannel;

  @override
  void initState() {
    super.initState();
    _messageChannel = context
        .read<DisplayOpenChatMessageBloc>()
        .createMessageChannel(
            changeEvent: PostgresChangeEvent.insert, callback: _callback);
    _messageChannel.subscribe();
  }

  @override
  void dispose() {
    super.dispose();
    _messageChannel.unsubscribe();
  }

  void _callback(
      OpenChatMessageEntity? oldRecord, OpenChatMessageEntity? newRecord) {
    if (newRecord != null) {
      setState(() {
        _messages.add(newRecord);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._chat.title ?? ''),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return OpenChatMessageItemWidget(_messages[index]);
                  })),
          const OpenChatTextFieldWidget()
        ],
      ),
    );
  }
}
