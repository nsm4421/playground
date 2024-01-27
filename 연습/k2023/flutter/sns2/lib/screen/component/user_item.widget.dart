import 'package:flutter/material.dart';
import 'package:my_app/domain/model/user/user.model.dart';
import 'package:my_app/repository/user/user.repository.dart';

import '../../configurations.dart';
import '../../core/response/response.dart';
import '../../repository/chat/chat.repository.dart';
import '../home/chat/chat_room.screen.dart';

class UserItemWidget extends StatefulWidget {
  const UserItemWidget(
      {super.key,
      required this.user,
      required this.currentUid,
      this.addFollowButton = false,
      this.addUnFollowButton = false});

  final UserModel user;
  final String currentUid;
  final bool addFollowButton;
  final bool addUnFollowButton;

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  _handleSendDirectMessage() => () async => await getIt<ChatRepository>()
      .getDirectMessageChatId(widget.user.uid!)
      .then((res) => res.data)
      .then((chatId) => chatId == null
          ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("can't send direct message..."),
              duration: Duration(seconds: 1),
            ))
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ChatRoomScreen(chatId))));

  _handleFollow() async => await getIt<UserRepository>()
          .followUser(widget.user.uid!)
          .then((response) {
        if (response.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("fail to following"),
            duration: Duration(seconds: 1),
          ));
        }
      });

  _handleUnFollow() async => await getIt<UserRepository>()
          .unFollowUser(widget.user.uid!)
          .then((response) {
        if (response.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("fail to unfollow"),
            duration: Duration(seconds: 1),
          ));
        }
      });

  @override
  Widget build(BuildContext context) => ListTile(
      // TODO : 클릭 시 개인 페이지로
      onTap: () {},
      leading: CircleAvatar(
        child: widget.user.profileImageUrls.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(widget.user.profileImageUrls[0]),
                        fit: BoxFit.cover)),
              )
            : const Icon(Icons.question_mark),
      ),
      title: Text(widget.user.nickname ?? ''),
      trailing: Wrap(
        children: [
          if (widget.addFollowButton)
            IconButton(
                tooltip: 'Follow',
                onPressed: _handleFollow,
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                )),
          if (widget.addUnFollowButton)
            IconButton(
                tooltip: 'UnFollow',
                onPressed: _handleUnFollow,
                icon: Icon(
                  Icons.remove,
                  color: Theme.of(context).colorScheme.primary,
                )),
          if (widget.currentUid != widget.user.uid)
            IconButton(
                tooltip: 'DM',
                onPressed: _handleSendDirectMessage,
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                )),
        ],
      ));
}
