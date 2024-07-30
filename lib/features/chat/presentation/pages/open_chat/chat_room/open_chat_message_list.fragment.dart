part of "open_chat_room.page.dart";

class OpenChatMessageListFragment extends StatelessWidget {
  const OpenChatMessageListFragment(
      {super.key, required currentPresence, required presences})
      : _currentPresence = currentPresence,
        _presences = presences;

  final PresenceEntity _currentPresence;
  final List<PresenceEntity> _presences;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenChatRoomBloc, OpenChatRoomState>(
        builder: (context, state) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: state.chatMessages.length,
          itemBuilder: (context, index) {
            final message = state.chatMessages[index];
            return OpenChatMessageItemWidget(
              message: message,
              isMine: _currentPresence.id == message.sender!.id,
              presence: _presences
                  .where((p) => p.id == message.sender!.id)
                  .firstOrNull,
            );
          });
    });
  }
}
