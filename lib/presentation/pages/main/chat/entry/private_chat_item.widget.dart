part of 'chat.page.dart';

class PrivateChatItemWidget extends StatefulWidget {
  const PrivateChatItemWidget(this._message, {super.key});

  final PrivateChatMessageEntity _message;

  @override
  State<PrivateChatItemWidget> createState() => _PrivateChatItemWidgetState();
}

class _PrivateChatItemWidgetState extends State<PrivateChatItemWidget> {
  _handleGoToChatRoom() {
    context.push(Routes.privateChatRoom.path,
        extra: widget._message.sender?.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _handleGoToChatRoom,
      title: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text("${widget._message.receiver?.nickname}",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          const Spacer(),
          SizedBox(
            child: Text(TimeUtil.timeAgo(widget._message.createdAt!),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary)),
          )
        ],
      ),
      subtitle:
          Text(widget._message.content ?? '', overflow: TextOverflow.ellipsis),
    );
  }
}
