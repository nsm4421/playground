import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:portfolio/presentation/bloc/auth/auth.bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../domain/entity/chat/private_chat_message.entity.dart';

class PrivateChatMessageItemWidget extends StatelessWidget {
  const PrivateChatMessageItemWidget(
      {super.key,
      required PrivateChatMessageEntity message,
      required PresenceEntity opponent})
      : _message = message,
        _opponent = opponent;

  final PrivateChatMessageEntity _message;
  final PresenceEntity _opponent;

  @override
  Widget build(BuildContext context) {
    final isMine =
        context.read<AuthBloc>().currentUser?.id == _message.sender?.id;
    return isMine
        ? _Mine(_message)
        : _Others(
            message: _message,
            opponent: _opponent,
          );
  }
}

class _Mine extends StatelessWidget {
  const _Mine(this._message, {super.key});

  final PrivateChatMessageEntity _message;

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
                  Text(timeago.format(_message.createdAt!),
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
      required PrivateChatMessageEntity message,
      required PresenceEntity opponent})
      : _message = message,
        _opponent = opponent;

  final PrivateChatMessageEntity _message;
  final PresenceEntity _opponent;

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
          if (_opponent.profileImage != null)
            CircleAvatar(
                radius: min(25, MediaQuery.of(context).size.width / 10),
                backgroundImage: CachedNetworkImageProvider(
                  _opponent.profileImage!,
                )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 닉네임
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Text(_opponent.nickname ?? "Left User",
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _opponent.nickname == null
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
                          Text(timeago.format(_message.createdAt!),
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
