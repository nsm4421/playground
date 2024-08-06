part of "private_chat_room.page.dart";

class PrivateChatRoomScreen extends StatefulWidget {
  const PrivateChatRoomScreen(
      {super.key, required this.chatId, required this.opponent});

  final String chatId;
  final PresenceEntity opponent;

  @override
  State<PrivateChatRoomScreen> createState() => _PrivateChatRoomScreenState();
}

class _PrivateChatRoomScreenState extends State<PrivateChatRoomScreen> {
  late ScrollController _scrollController;
  bool _isFetchButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _isFetchButtonVisible = _scrollController.offset >=
            _scrollController.position.maxScrollExtent - 50;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _handlePop() {
    if (context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // 뒤로가기 버튼
          leading: IconButton(
            onPressed: _handlePop,
            icon: const Icon(Icons.clear),
          ),
          // 상대방 유저 닉네임
          title: Text(widget.opponent.nickname!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  overflow: TextOverflow.ellipsis)),
        ),
        body: Column(children: [
          // 더 가져오기 버튼
          if (_isFetchButtonVisible)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: FetchMoreButtonWidget(),
            ),
          // 메시지 목록
          Expanded(
              child: SingleChildScrollView(
                  reverse: true,
                  controller: _scrollController,
                  child: PrivateChatMessageListFragment(widget.opponent))),
          // 텍스트 입력창
          PrivateChatRoomTextFieldWidget(widget.opponent.id!)
        ]));
  }
}
