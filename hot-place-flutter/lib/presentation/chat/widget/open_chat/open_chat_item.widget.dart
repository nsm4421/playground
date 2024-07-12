import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/feed/widget/hashtag_list.widget.dart';
import 'package:hot_place/presentation/setting/widget/profile_image.widget.dart';

import '../../../../core/constant/route.constant.dart';
import '../../../../data/entity/chat/open_chat/room/open_chat.entity.dart';

class OpenChatItemWidget extends StatelessWidget {
  const OpenChatItemWidget(this._chat, {super.key});

  final OpenChatEntity _chat;

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
            leading: ProfileImageWidget(_chat.host?.profileImage, radius: 20),

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
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: HashtagListWidget(
                _chat.hashtags,
                textStyle:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            )
        ],
      );
}
