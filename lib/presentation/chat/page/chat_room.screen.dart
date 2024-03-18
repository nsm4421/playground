import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/constant/response.constant.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/domain/entity/chat/message.entity.dart';

import 'package:hot_place/presentation/chat/bloc/chat_room/chat_room.bloc.dart';
import 'package:hot_place/presentation/chat/bloc/chat_room/chat_room.event.dart';
import 'package:hot_place/presentation/chat/bloc/chat_room/chat_room.state.dart';

import '../component/message_item.widget.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen(this.chatId, {super.key});

  final String chatId;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<ChatRoomBloc>()..add(InitChatRoom(chatId)),
        child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
          builder: (_, state) {
            switch (state.status) {
              case Status.initial:
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.success:
                return const _ChatRoomView();
              case Status.error:
                return Center(
                    child: Text("Error",
                        style: Theme.of(context).textTheme.displayLarge));
            }
          },
        ),
      );
}

class _ChatRoomView extends StatefulWidget {
  const _ChatRoomView({super.key});

  @override
  State<_ChatRoomView> createState() => _ChatRoomViewState();
}

class _ChatRoomViewState extends State<_ChatRoomView> {
  late TextEditingController _tec;
  late ScrollController _sc;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _sc = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
    _sc.dispose();
  }

  // 맨 아래로 스크롤
  _jumpToBottom() => _sc.animateTo(
        _sc.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );

  // 메세지 보내기
  _handleSend() async {
    context.read<ChatRoomBloc>().add(SendMessage(content: _tec.text));
    _jumpToBottom();
    _tec.clear();
  }

  // 화면 닫기
  _handlePop() => context.pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            leading: const CircleAvatar(child: null),
            title: Text(context.read<ChatRoomBloc>().state.opponent.username ??
                "Unknown"),
            actions: [
              IconButton(onPressed: _handlePop, icon: const Icon(Icons.clear))
            ]),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageEntity>>(
                stream: context.read<ChatRoomBloc>().state.stream,
                builder: (_, snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _jumpToBottom();
                    });
                    return ListView.builder(
                        controller: _sc,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) =>
                            MessageItem(snapshot.data![index]));
                  }
                },
              ),
            ),

            // 채팅 입력창
            TextField(
                controller: _tec,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: _handleSend, icon: const Icon(Icons.send))))
          ],
        ));
  }
}
