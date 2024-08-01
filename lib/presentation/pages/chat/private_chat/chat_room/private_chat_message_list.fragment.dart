part of "private_chat_room.page.dart";

class PrivateChatMessageListFragment extends StatefulWidget {
  const PrivateChatMessageListFragment(this._opponent, {super.key});

  final PresenceEntity _opponent;

  @override
  State<PrivateChatMessageListFragment> createState() =>
      _PrivateChatMessageListFragmentState();
}

class _PrivateChatMessageListFragmentState
    extends State<PrivateChatMessageListFragment> {
  late RealtimeChannel _channel;

  @override
  void initState() {
    super.initState();
    _channel = context.read<PrivateChatRoomBloc>().getPrivateChatMessageChannel(
        onInsert: (message) {
      context
          .read<PrivateChatRoomBloc>()
          .add(AwareNewPrivateChatMessageEvent(message));
    }, onDelete: (message) {
      context
          .read<PrivateChatRoomBloc>()
          .add(AwarePrivateChatMessageDeletedEvent(message));
    }).subscribe();
  }

  @override
  void dispose() {
    super.dispose();
    _channel.unsubscribe();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivateChatRoomBloc, PrivateChatRoomState>(
        builder: (context, state) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: state.chatMessages.length,
          itemBuilder: (context, index) => PrivateChatMessageItemWidget(
              message: state.chatMessages[index], opponent: widget._opponent));
    });
  }
}
