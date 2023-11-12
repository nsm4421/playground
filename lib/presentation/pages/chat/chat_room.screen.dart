import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/domain/model/chat/chat_message/chat_message.model.dart';
import 'package:my_app/domain/model/chat/chat_room/chat_room.model.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_message/chat_message.event.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_message/chat_message.state.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.bloc.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.event.dart';

import '../../../core/constant/enums/status.enum.dart';
import '../../../dependency_injection.dart';
import '../../../domain/repository/chat.repository.dart';
import 'bloc/chat_message/chat_message.bloc.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen(this.chatRoom, {super.key});

  final ChatRoomModel chatRoom;

  @override
  Widget build(BuildContext context) => chatRoom.chatRoomId == null
      ? const Center(child: Text("ERROR"))
      : BlocProvider(
          create: (_) => getIt<ChatBloc>()
            ..add(ChatMessageInitializedEvent(chatRoom.chatRoomId!)),
          child: BlocBuilder<ChatBloc, ChatMessageState>(builder: (_, state) {
            switch (state.status) {
              case Status.initial:
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return const Center(child: Text("ERROR"));
              case Status.success:
                return _ChatRoomView(
                    chatRoom: chatRoom, messages: state.messages);
            }
          }));
}

class _ChatRoomView extends StatefulWidget {
  const _ChatRoomView(
      {super.key, required this.chatRoom, required this.messages});

  final ChatRoomModel chatRoom;
  final List<ChatMessageModel> messages;

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
    _sc = ScrollController(initialScrollOffset: double.infinity);
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
    _sc.dispose();
    getIt<ChatRoomBloc>().add(LeaveChatRoomEvent(widget.chatRoom.chatRoomId!));
  }

  _jumpToEndDown() {
    _sc.animateTo(
      _sc.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  // 메세지 보내기
  _handleSendMessage() {
    if (_tec.text.isEmpty) return;
    context.read<ChatBloc>().add(ChatMessageSentEvent(
        chatRoomId: widget.chatRoom.chatRoomId!,
        message: _tec.text.trimRight()));
    _tec.clear();
    _jumpToEndDown();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(title: Text(widget.chatRoom.chatRoomName ?? '')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _sc,
              child: StreamBuilder<List<ChatMessageModel>>(
                stream: getIt<ChatRepository>()
                    .getChatMessageStream(widget.chatRoom.chatRoomId!),
                initialData: widget.messages,
                builder: (_, AsyncSnapshot<List<ChatMessageModel>> snapshot) =>
                    (snapshot.connectionState == ConnectionState.waiting)
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: snapshot.data!
                                .map((e) => _ChatMessageItem(e))
                                .toList(),
                          ),
              ),
            ),
          ),
          _ChatMessageTextField(tec: _tec, callback: _handleSendMessage)
        ],
      )

      // Column(
      //   children: [
      //     Expanded(
      //         child: SingleChildScrollView(
      //           controller: _sc,
      //           child: StreamBuilder<List<ChatMessageModel>>(
      //             stream: getIt<ChatRepository>()
      //                 .getChatMessageStream(widget.chatRoom.chatRoomId!),
      //             initialData: widget.messages,
      //             builder: (_, AsyncSnapshot<List<ChatMessageModel>> snapshot) =>
      //             (snapshot.connectionState == ConnectionState.waiting)
      //                 ? const Center(child: CircularProgressIndicator())
      //                 : ListView.builder(
      //               shrinkWrap: true,
      //               itemCount: snapshot.data?.length ?? 0,
      //               itemBuilder: (_, int index) =>
      //                   _ChatMessageItem(snapshot.data![index]),
      //             ),
      //           ),
      //         )),
      //     _ChatMessageTextField(tec: _tec, callback: _handleSendMessage)
      //   ],
      // ),
      );
}

class _ChatMessageTextField extends StatelessWidget {
  const _ChatMessageTextField(
      {required this.tec, required this.callback, super.key});

  final TextEditingController tec;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) => TextField(
        controller: tec,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
              onPressed: callback,
              icon: Icon(Icons.send,
                  color: Theme.of(context).colorScheme.primary)),
        ),
        minLines: 1,
        maxLines: 5,
      );
}

class _ChatMessageItem extends StatelessWidget {
  const _ChatMessageItem(this.chatMessage, {super.key});

  static const double _widthRatio = 0.7;
  static const double _paddingSize = 15;
  static const double _verticalMargin = 5;
  static const double _horizontalMargin = 8;

  final ChatMessageModel chatMessage;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: _verticalMargin, horizontal: _horizontalMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(_paddingSize),
              width: MediaQuery.of(context).size.width * _widthRatio,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                chatMessage.message ?? '',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      );
}
