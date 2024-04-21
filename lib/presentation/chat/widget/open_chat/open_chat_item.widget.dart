import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/route.constant.dart';
import '../../../../data/entity/chat/open_chat/room/open_chat.entity.dart';

class OpenChatItemWidget extends StatelessWidget {
  const OpenChatItemWidget(this._chat, {super.key});

  final OpenChatEntity _chat;

  static const double _imageSize = 30;

  _goToOpenChat(BuildContext ctx) => () {
        ctx.push("${Routes.openChatRoom.path}/${_chat.id}");
      };

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ListTile(
            // 방제목
            title: Text(_chat.title ?? '',
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary)),

            // 프로필 이미지
            leading: CircleAvatar(
                radius: _imageSize,
                child: _chat.host?.profileImage != null
                    ? Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    NetworkImage(_chat.host!.profileImage!))))
                    : const Icon(Icons.question_mark)),

            // 닉네임
            subtitle: Text(_chat.host?.nickname ?? "Unknown",
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary)),

            // 버튼
            trailing: IconButton(
              onPressed: _goToOpenChat(context),
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),

          // 해시태그
          if (_chat.hashtags.isNotEmpty)
            Container(
                margin: const EdgeInsets.only(top: 8, bottom: 10),
                padding: const EdgeInsets.only(left: 2 * _imageSize),
                alignment: Alignment.topLeft,
                child: Wrap(
                    children: _chat.hashtags
                        .map((text) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer),
                            child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(Icons.tag,
                                          size: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      Text(text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ]))))
                        .toList()))
        ],
      );
}
