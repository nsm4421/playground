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
  List<ChatMessageEntity> _messages = [];

  @override
  void initState() {
    super.initState();
    _currentPresence =
        PresenceEntity.fromEntity(context.read<AuthBloc>().account!);
    _channel = context
        .read<OpenChatBloc>()
        .getOpenChatMessageChannel(
            chatId: widget._chat.id!,
            onInsert: (message) {
              setState(() {
                _messages.add(message);
              });
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
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: Text("Presences",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Divider()),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final presence = _presences[index];
                      return ListTile(
                        leading: CircleAvatar(
                            radius:
                                min(25, MediaQuery.of(context).size.width / 10),
                            backgroundImage: CachedNetworkImageProvider(
                                presence.profileImage!)),
                        title: Text(presence.nickname!),
                      );
                    },
                    separatorBuilder: (context, index) => const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        child: Divider()),
                    itemCount: _presences.length),
              ],
            ),
          );
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
          // 메시지 목록
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _currentPresence.id == message.createdBy
                      ? MyMessageItemWidget(message)
                      : OtherMessageItemWidget(
                          message: message,
                          presence: _presences
                              .where((p) => p.id == message.createdBy)
                              .firstOrNull);
                }),
          ),

          // 텍스트 입력창
          Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: OpenChatRoomTextFieldWidget(widget._chat.id!))
        ],
      ),
    );
  }
}
