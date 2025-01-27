part of '../../../export.pages.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen(this._chat, {super.key});

  final GroupChatEntity _chat;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> with DebounceMixIn {
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  late StreamSubscription<MessageEntity> _subscription;
  late String _currentUid;

  bool _showJumpButton = false;

  List<MessageEntity> _messages = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController()
      ..addListener(_handleScrollController);
    _subscription = context.read<GroupChatBloc>().messageStream.listen((data) {
      setState(() {
        _messages = [data, ..._messages];
      });
    });
    _currentUid = context.read<AuthBloc>().state.user!.id;
  }

  @override
  dispose() {
    super.dispose();
    _textEditingController.dispose();
    _scrollController
      ..removeListener(_handleScrollController)
      ..dispose();
    _subscription.cancel();
    cancelTimer();
  }

  _handleSendMessage() {
    final text = _textEditingController.text.trim();
    if (text.isNotEmpty) {
      context
          .read<GroupChatBloc>()
          .add(SendMessageEvent(content: text, currentUid: _currentUid));
      _textEditingController.clear();
    }
  }

  _handleScrollController() {
    final currentPosition = _scrollController.position.pixels;
    final top = _scrollController.position.maxScrollExtent;
    final bottom = _scrollController.position.minScrollExtent;
    if (currentPosition == top) {
      // TODO : Fetch More message
    }
    debounce(() {
      setState(() {
        _showJumpButton = currentPosition != bottom;
      });
      Timer(2.sec, () {
        setState(() {
          _showJumpButton = false;
        });
      });
    });
  }

  _handleJumpToBottom() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        curve: Curves.easeInSine, duration: 500.ms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget._chat.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final item = _messages[index];
          final isMine = _currentUid == item.sender.id;
          return Container(
            alignment: isMine ? Alignment.topRight : Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMine)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: CircleAvatar(),
                  ), // TODO : 프로필 사진
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isMine)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 8),
                        child: Text(item.sender.nickname,
                            style: context.textTheme.labelMedium),
                      ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isMine
                                ? context.colorScheme.primaryContainer
                                : context.colorScheme.tertiaryContainer),
                        child: Text(
                          item.content,
                          style: context.textTheme.bodyMedium?.copyWith(
                              color: isMine
                                  ? context.colorScheme.onPrimaryContainer
                                  : context
                                      .colorScheme.onTertiaryContainer),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
        child: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: _handleSendMessage,
                icon: Icon(
                  Icons.send,
                  color: context.colorScheme.primary,
                ),
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _showJumpButton
          ? FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: _handleJumpToBottom,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.arrow_downward_sharp,
                color: context.colorScheme.tertiary,
              ),
            )
          : null,
    );
  }
}
