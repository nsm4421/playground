part of 'open_chat_room.page.dart';

class OpenChatRoomScreen extends StatefulWidget {
  const OpenChatRoomScreen(this._chat, {super.key});

  final OpenChatEntity _chat;

  @override
  State<OpenChatRoomScreen> createState() => _OpenChatRoomScreenState();
}

class _OpenChatRoomScreenState extends State<OpenChatRoomScreen> {
  List<OpenChatMessageEntity> _messages = [];
  List<PresenceEntity> _presences = [];
  late RealtimeChannel _messageChannel;

  @override
  void initState() {
    super.initState();
    _messageChannel =
        context.read<DisplayOpenChatMessageBloc>().getMessageChannel(_onInsert);
    _messageChannel.subscribe((status, error) async {
      if (status == RealtimeSubscribeStatus.subscribed) {
        final state = (context.read<UserBloc>().state as UserLoadedState);
        await _messageChannel
            .track(PresenceEntity.fromAccount(state.account).toJson());
      }
    })
        // 새로운 유저가 채팅방에 들어오는 경우
        .onPresenceJoin((RealtimePresenceJoinPayload payload) {
      final newPresences = payload.newPresences
          .map((p) => p.payload)
          .map(PresenceEntity.fromJson);
      setState(() {
        _presences.addAll(newPresences);
      });
    })
        // 유저가 채팅방을 떠나는 경우
        .onPresenceLeave((RealtimePresenceLeavePayload payload) {
      setState(() {
        final letUid = payload.leftPresences
            .map((p) => p.payload)
            .map(PresenceEntity.fromJson)
            .map((entity) => entity.uid);
        _presences.removeWhere((entity) => letUid.contains(entity.uid));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messageChannel.unsubscribe();
  }

  _onInsert(OpenChatMessageEntity entity) {
    setState(() {
      _messages.add(entity);
    });
  }

  _handleShowPresences() {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) {
          return PresencesFragment(_presences);
        });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        (context.read<UserBloc>().state as UserLoadedState).account;
    return Scaffold(
      appBar: AppBar(
          title: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: widget._chat.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w800)),
            TextSpan(
                text: ' (${_presences.length})',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.normal))
          ])),
          actions: [
            IconButton(
              onPressed: _handleShowPresences,
              icon: const Icon(Icons.account_circle),
              tooltip: "참여자 목록",
            )
          ],
          elevation: 0),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isMine = currentUser.id == message.createdBy;
                    final presence = _presences
                            .where((p) => p.uid == message.createdBy)
                            .firstOrNull ??
                        const PresenceEntity();
                    return OpenChatMessageItemWidget(
                        message: message, isMine: isMine, presence: presence);
                  })),
          const OpenChatTextFieldWidget()
        ],
      ),
    );
  }
}
