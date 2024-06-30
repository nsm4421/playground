part of 'open_chat.page.dart';

class OpenChatItemWidget extends StatefulWidget {
  const OpenChatItemWidget(this._chat, {super.key});

  final OpenChatEntity _chat;

  @override
  State<OpenChatItemWidget> createState() => _OpenChatItemWidgetState();
}

class _OpenChatItemWidgetState extends State<OpenChatItemWidget> {
  _handleGoToChatRoom() {
    context.push(Routes.openChatRoom.path, extra: widget._chat);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _handleGoToChatRoom,
      title: Text(widget._chat.title ?? '',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary)),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget._chat.lastMessage ?? '',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
