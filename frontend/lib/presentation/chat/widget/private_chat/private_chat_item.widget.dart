import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/util/date.util.dart';
import 'package:hot_place/data/entity/chat/private_chat/room/private_chat.entity.dart';

import '../../../../core/constant/route.constant.dart';

class PrivateChatItemWidget extends StatelessWidget {
  const PrivateChatItemWidget(this._chat, {super.key});

  final PrivateChatEntity _chat;

  _handleGoToPrivateChatRoom(BuildContext ctx) {
    ctx.push('${Routes.privateChatRoom.path}/${_chat.id}',
        extra: _chat.opponent!.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // 프로필 이미지
      leading: _chat.opponent?.profileImage == null
          ? const CircleAvatar(child: Icon(Icons.question_mark))
          : Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(_chat.opponent!.profileImage!)))),

      // 최근 메세지
      title: Text(_chat.lastMessage ??
          '${_chat.opponent?.nickname ?? 'Unknown'}님이 메세지를 보냈습니다'),

      // 보낸 날짜
      subtitle: _chat.updatedAt != null
          ? Text(DateUtil.formatTimeAgo(_chat.updatedAt!))
          : null,

      // 채팅방 이동 버튼
      trailing: IconButton(
        icon: const Icon(Icons.chevron_right),
        onPressed: _handleGoToPrivateChatRoom(context),
      ),
    );
  }
}
