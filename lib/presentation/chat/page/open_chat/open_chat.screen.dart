import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';

import '../../../../core/constant/route.constant.dart';

class OpenChatScreen extends StatefulWidget {
  const OpenChatScreen({super.key});

  @override
  State<OpenChatScreen> createState() => _OpenChatScreenState();
}

class _OpenChatScreenState extends State<OpenChatScreen> {
  _handleGoToCreateOpenChatPage() => context.push(Routes.createOpenChat.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("오픈 채팅방"),
        actions: [
          IconButton(
              onPressed: _handleGoToCreateOpenChatPage,
              icon: const Icon(Icons.add_box_outlined),
              tooltip: "채팅방 만들기")
        ],
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: 50,
        itemBuilder: (_, index) {
          // TODO : 실제 오픈 채팅방 목록
          return _OpenChatItem(OpenChatEntity(
              id: '1',
              title: '채팅하기 $index',
              host: const UserEntity(
                  id: "test",
                  nickname: "test nickname",
                  profileImage:
                      "https://image-cdn.hypb.st/https%3A%2F%2Fkr.hypebeast.com%2Ffiles%2F2023%2F02%2Fdemon-slayer-kimetsu-no-yaiba-to-the-swordsmith-village-korea-release-info-01.jpg?cbr=1&q=90"),
              hashtags: ['test1', 'test2'],
              createdAt: DateTime.now()));
        },
        separatorBuilder: (_, __) => const Divider(indent: 30, endIndent: 30),
      ),
    );
  }
}

class _OpenChatItem extends StatelessWidget {
  const _OpenChatItem(this._chat, {super.key});

  final OpenChatEntity _chat;

  static const double _imageSize = 30;

  // TODO : 오픈 채팅방으로 이동
  _goToOpenChat(BuildContext ctx) => () {};

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
