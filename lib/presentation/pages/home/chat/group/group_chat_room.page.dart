part of '../../../export.pages.dart';

class GroupChatRoomPage extends StatelessWidget {
  const GroupChatRoomPage(this._chatId, {super.key});

  final String _chatId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<GroupChatBloc>(param1: _chatId)..add(JoinGroupChatEvent()),
      child: ChatRoomScreen(chatId: _chatId),
    );
  }
}
