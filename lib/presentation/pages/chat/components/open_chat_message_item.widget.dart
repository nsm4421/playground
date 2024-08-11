import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/core/util/date.util.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../domain/entity/chat/open_chat_message.entity.dart';

class OpenChatMessageItemWidget extends StatelessWidget {
  const OpenChatMessageItemWidget(
      {super.key,
      required OpenChatMessageEntity message,
      PresenceEntity? presence,
      isMine = true})
      : _message = message,
        _presence = presence,
        _isMine = isMine;

  final OpenChatMessageEntity _message;
  final PresenceEntity? _presence;
  final bool _isMine;

  @override
  Widget build(BuildContext context) {
    return _isMine
        ? _Mine(_message)
        : _Others(message: _message, presence: _presence);
  }
}

class _Mine extends StatelessWidget {
  const _Mine(this._message, {super.key});

  final OpenChatMessageEntity _message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        width: MediaQuery.of(context).size.width * 3 / 4,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 메세지
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: Text(_message.content ?? "",
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600)),
            ),
            // 작성시간
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_message.createdAt!.format(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Others extends StatelessWidget {
  const _Others(
      {super.key,
      required OpenChatMessageEntity message,
      PresenceEntity? presence})
      : _message = message,
        _presence = presence;

  final OpenChatMessageEntity _message;
  final PresenceEntity? _presence;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 사진
          if (_presence?.profileImage != null)
            CircleAvatar(
                radius: min(25, MediaQuery.of(context).size.width / 10),
                backgroundImage: CachedNetworkImageProvider(
                  _presence!.profileImage!,
                )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 닉네임
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text(_presence?.nickname ?? "Left User",
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _presence?.nickname == null
                            ? Theme.of(context).colorScheme.onSecondaryFixed
                            : Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w600)),
              ),
              // 메세지
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                width: MediaQuery.of(context).size.width * 3 / 4,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 메세지
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      child: Text(_message.content ?? "",
                          overflow: TextOverflow.clip,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  fontWeight: FontWeight.w600)),
                    ),
                    // 작성시간
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_message.createdAt!.format(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryFixed,
                                      fontWeight: FontWeight.w300))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
