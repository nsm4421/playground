part of 'chat.page.dart';

class PrivateChatListFragment extends StatefulWidget {
  const PrivateChatListFragment(this._messages, {super.key});

  final List<PrivateChatMessageEntity> _messages;

  @override
  State<PrivateChatListFragment> createState() =>
      _PrivateChatListFragmentState();
}

class _PrivateChatListFragmentState extends State<PrivateChatListFragment> {
  _handleGoToChatRoom() {
    context.push(Routes.privateChatRoom.path);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget._messages.length,
        itemBuilder: (context, index) {
          final message = widget._messages[index];
          return ListTile(
            onTap: _handleGoToChatRoom,
            title: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text("${message.receiver?.nickname}",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                ),
                const Spacer(),
                SizedBox(
                  child: Text(TimeUtil.timeAgo(message.createdAt!),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary)),
                )
              ],
            ),
            subtitle:
                Text(message.content ?? '', overflow: TextOverflow.ellipsis),
          );
        });
  }
}
