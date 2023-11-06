import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/domain/model/chat/chat_message/chat_message.model.dart';
import 'package:my_app/domain/model/chat/chat_room/chat_room.model.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_message/chat_message.event.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_message/chat_message.state.dart';

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

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  // 메세지 보내기
  _handleSendMessage() {
    if (_tec.text.isEmpty) return;
    context.read<ChatBloc>().add(ChatMessageSentEvent(
        chatRoomId: widget.chatRoom.chatRoomId!,
        message: _tec.text.trimRight()));
    _tec.clear();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(title: Text(widget.chatRoom.chatRoomName ?? '')),
        body: StreamBuilder<List<ChatMessageModel>>(
          stream: getIt<ChatRepository>()
              .getChatMessageStream(widget.chatRoom.chatRoomId!),
          initialData: widget.messages,
          builder: (_, snapshot) => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      children: snapshot.data!
                          .map((e) => _ChatMessageItem(e))
                          .toList()),
                ),
              ),
              _ChatMessageTextField(tec: _tec, callback: _handleSendMessage)
            ],
          ),
        ),
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

  final ChatMessageModel chatMessage;

  @override
  Widget build(BuildContext context) => Text(chatMessage.message ?? '');
}
