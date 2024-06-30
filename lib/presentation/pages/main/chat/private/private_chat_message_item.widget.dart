part of 'private_chat.page.dart';

class PrivateChatMessageItemWidget extends StatelessWidget {
  final PrivateChatMessageEntity _message;
  final bool _isMine;

  const PrivateChatMessageItemWidget(
      {super.key,
      required PrivateChatMessageEntity message,
      required bool isMine})
      : _message = message,
        _isMine = isMine;

  @override
  Widget build(BuildContext context) {
    final profileUrl = _isMine ? null : _message.receiver?.profileUrl;
    final nickname = _isMine ? null : _message.receiver?.nickname;

    return Padding(
      padding: EdgeInsets.only(
        left: _isMine ? MediaQuery.of(context).size.width / 4 : 0,
        right: _isMine ? 0 : MediaQuery.of(context).size.width / 4,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 3 / 4,
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _isMine
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.secondaryContainer),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 사진
            if (profileUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: AvatarWidget(profileUrl, radius: 20),
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 닉네임
                if (nickname != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 8),
                    child: Text(nickname,
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                  ),

                // 본문
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 4 - 90,
                  child: Text(_message.content ?? '',
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: _isMine
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary)),
                ),

                // 작성 시간
                if (_message.createdAt != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(TimeUtil.timeAgo(_message.createdAt!),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary)),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
