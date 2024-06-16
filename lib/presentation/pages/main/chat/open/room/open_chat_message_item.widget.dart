part of 'open_chat_room.page.dart';

class OpenChatMessageItemWidget extends StatelessWidget {
  const OpenChatMessageItemWidget(this._message, {super.key});

  final OpenChatMessageEntity _message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.4),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.primaryContainer),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // 본문
              Text(_message.content ?? '??',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary)),
              const SizedBox(height: 10),

              // 작성시간
              if (_message.createdAt != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(TimeUtil.timeAgo(_message.createdAt!),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary)),
                  ],
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
