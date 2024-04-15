import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/case/get_open_chat_steram.usecase.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/open_chat.usecase.dart';

import '../../../../core/constant/route.constant.dart';
import '../../widget/open_chat_item.widget.dart';

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
        body: const _OpenChatList());
  }
}

class _OpenChatList extends StatefulWidget {
  const _OpenChatList({super.key});

  @override
  State<_OpenChatList> createState() => _OpenChatListState();
}

class _OpenChatListState extends State<_OpenChatList> {
  late Stream<List<OpenChatEntity>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = getIt<OpenChatUseCase>().openChatStream.call();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<OpenChatEntity>>(
        stream: _stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
            case ConnectionState.none:
            case ConnectionState.active:
              final data = snapshot.data ?? [];
              return ListView.separated(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (_, index) => OpenChatItemWidget(data[index]),
                separatorBuilder: (_, __) =>
                    const Divider(indent: 30, endIndent: 30),
              );
          }
        });
  }
}
