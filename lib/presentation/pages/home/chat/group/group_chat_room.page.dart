part of '../../../export.pages.dart';

class GroupChatRoomPage extends StatelessWidget {
  const GroupChatRoomPage(this._chat, {super.key});

  final GroupChatEntity _chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<GroupChatBloc>(param1: _chat.id)..add(JoinGroupChatEvent()),
      child: ChatRoomScreen(_chat),
    );
  }
}
