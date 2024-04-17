import 'package:flutter/material.dart';
import 'package:hot_place/core/util/date.util.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../data/entity/chat/open_chat/message/open_chat_message.entity.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget(
      {super.key,
      required OpenChatMessageEntity chatMessage,
      required UserEntity currentUser})
      : _currentUser = currentUser,
        _chatMessage = chatMessage;

  final OpenChatMessageEntity _chatMessage;
  final UserEntity _currentUser;

  static const double _avatarSize = 20;

  @override
  Widget build(BuildContext context) {
    bool isSender = _currentUser.id == _chatMessage.sender?.id;

    return Container(
        margin: const EdgeInsets.only(top: 15),
        alignment: isSender ? Alignment.topRight : Alignment.topLeft,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (isSender
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.secondaryContainer)
                    .withOpacity(0.7)),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 상대방의 프로필 사진, 닉네임
                  if (!isSender)
                    Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          // 프로필 사진
                          if (_chatMessage.sender?.profileImage != null)
                            CircleAvatar(
                              radius: _avatarSize,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(_chatMessage
                                            .sender!.profileImage!))),
                              ),
                            ),
                          const SizedBox(width: 10),
                          Text(_chatMessage.sender?.nickname ?? "Unknown",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold))
                        ])),

                  // 본문
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(_chatMessage.content ?? "???",
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodyLarge)),

                  // 보낸 시간
                  if (_chatMessage.createdAt != null)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Align(
                            alignment: isSender
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Text(
                                DateUtil.formatTimeAgo(_chatMessage.createdAt!),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary))))
                ])));
  }
}
