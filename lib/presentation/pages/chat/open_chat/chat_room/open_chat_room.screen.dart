part of "open_chat_room.page.dart";

class OpenChatRoomScreen extends StatefulWidget {
  const OpenChatRoomScreen(this._chat, {super.key});

  final OpenChatEntity _chat;

  @override
  State<OpenChatRoomScreen> createState() => _OpenChatRoomScreenState();
}

class _OpenChatRoomScreenState extends State<OpenChatRoomScreen> {
  late RealtimeChannel _channel;
  late PresenceEntity _currentPresence;
  List<PresenceEntity> _presences = [];

  @override
  void initState() {
    super.initState();
    _currentPresence =
        PresenceEntity.fromEntity(context.read<AuthBloc>().account!);
    _channel =
        context.read<OpenChatRoomBloc>().getOpenChatMessageChannel((message) {
      context.read<OpenChatRoomBloc>().add(NewOpenChatMessageEvent(message));
    })
            // 채널 구독 시 이벤트
            .subscribe((status, error) async {
      if (status == RealtimeSubscribeStatus.subscribed) {
        await _channel.track(_currentPresence.toJson());
      }
    })
            // 채팅방 입장 시
            .onPresenceJoin((RealtimePresenceJoinPayload payload) {
      final newPresences = payload.newPresences
          .map((p) => p.payload)
          .map(PresenceEntity.fromJson);
      setState(() {
        _presences.addAll(newPresences);
      });
    })
            // 채팅방 나가는 경우
            .onPresenceLeave((RealtimePresenceLeavePayload payload) {
      setState(() {
        final letUid = payload.leftPresences
            .map((p) => p.payload)
            .map(PresenceEntity.fromJson)
            .map((entity) => entity.id);
        _presences.removeWhere((entity) => letUid.contains(entity.id));
      });
    });
  }

  _handleShowPresence() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return PresenceListFragment(_presences);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _channel.unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._chat.title ?? ""),
        actions: [
          IconButton(
              onPressed: _handleShowPresence,
              icon: const Icon(Icons.account_circle))
        ],
      ),
      body: Column(
        children: [
          // 더 가져오기 버튼
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: FetchMoreButtonWidget(widget._chat.id!),
          ),

          // 메시지 목록
          Expanded(
            child: OpenChatMessageListFragment(
                presences: _presences, currentPresence: _currentPresence),
          ),

          // 텍스트 입력창
          const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: OpenChatRoomTextFieldWidget())
        ],
      ),
    );
  }
}
