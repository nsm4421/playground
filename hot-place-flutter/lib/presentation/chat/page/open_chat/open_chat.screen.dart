import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/data/entity/chat/open_chat/room/open_chat.entity.dart';
import 'package:hot_place/domain/usecase/chat/room/open_chat.usecase.dart';
import 'package:hot_place/presentation/auth/widget/loading.widget.dart';
import 'package:hot_place/presentation/chat/bloc/chat_bloc.module.dart';
import 'package:hot_place/presentation/chat/bloc/room/open_chat/open_chat.bloc.dart';
import 'package:hot_place/presentation/chat/widget/error/open_chat_error.widget.dart';

import '../../../../core/constant/route.constant.dart';
import '../../widget/open_chat/open_chat_item.widget.dart';

class OpenChatScreen extends StatelessWidget {
  const OpenChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ChatBlocModule>().openChatBloc
          ..add(GetOpenChatStreamEvent())
          ..add(InitOpenChatEvent()),
        child: BlocBuilder<OpenChatBloc, OpenChatState>(builder: (_, state) {
          if (state is InitialOpenChatState || state is OpenChatSuccessState) {
            return const _View();
          } else if (state is OpenChatLoadingState) {
            return const LoadingWidget('로딩중입니다...');
          } else if (state is OpenChatFailureState) {
            return OpenChatErrorWidget(state.message);
          }
          return OpenChatErrorWidget('알수 없는 오류가 발생했습니다');
        }));
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
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
    _stream = getIt<OpenChatUseCase>().chatStream.call();
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
