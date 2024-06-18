part of 'open_chat_room.page.dart';

class OpenChatMessageItemWidget extends StatelessWidget {
  const OpenChatMessageItemWidget(
      {super.key,
      required PresenceEntity presence,
      required OpenChatMessageEntity message,
      required bool isMine})
      : _presence = presence,
        _message = message,
        _isMine = isMine;

  final PresenceEntity _presence;
  final OpenChatMessageEntity _message;
  final bool _isMine;

  @override
  Widget build(BuildContext context) {
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
            if (_presence.profileUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: AvatarWidget(_presence.profileUrl, radius: 20),
              ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 닉네임
                if (_presence.nickname.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 8),
                    child: Text(_presence.nickname,
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                  ),

                // 본문
                SizedBox(
                  width: MediaQuery.of(context).size.width * 3 / 4 - 90,
                  child: Text(_message.content ?? '-',
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
