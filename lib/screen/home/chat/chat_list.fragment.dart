import 'package:flutter/material.dart';
import 'package:my_app/api/auth/auth.api.dart';
import 'package:my_app/api/chat/chat.api.dart';
import 'package:my_app/core/util/time_diff.util.dart';
import 'package:my_app/domain/model/chat/chat.model.dart';
import '../../../configurations.dart';
import '../../../domain/model/user/user.model.dart';
import 'chat_room.screen.dart';

class ChatListFragment extends StatefulWidget {
  const ChatListFragment({super.key});

  @override
  State<ChatListFragment> createState() => _ChatListFragmentState();
}

class _ChatListFragmentState extends State<ChatListFragment> {
  late Stream<List<ChatModel>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = getIt<ChatApi>().getChatStream();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<ChatModel>>(
      stream: _stream,
      builder: (_, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData && !snapshot.hasError) {
              return _ChatListFragmentView(snapshot.data!);
            }
        }
        return const Center(child: Text("ERROR"));
      });
}

class _ChatListFragmentView extends StatelessWidget {
  const _ChatListFragmentView(this.chats, {super.key});

  final List<ChatModel> chats;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) =>
                    _ChatItem(chats[index]),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: chats.length,
              )
            ],
          ),
        ),
      );
}

class _ChatItem extends StatefulWidget {
  const _ChatItem(this._chat);

  final ChatModel _chat;

  @override
  State<_ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<_ChatItem> {
  _handleGoToChat() => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) =>
              ChatRoomScreen(widget._chat.chatId!)));

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: _handleGoToChat,
        title: Text(
            widget._chat.users
                .where((user) => user.uid != getIt<AuthApi>().currentUid)
                .map((user) => user.nickname)
                .where((nickname) => nickname != null)
                .toList()
                .join(','),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary)),
        subtitle: widget._chat.lastMessage != null
            ? Text(widget._chat.lastMessage?.content ?? 'no',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary))
            : const SizedBox(),
        trailing: widget._chat.lastSeen != null
            ? Text(
                TimeDiffUtil.getTimeDiffRep(widget._chat.lastSeen!),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              )
            : const SizedBox(),
      );
}
