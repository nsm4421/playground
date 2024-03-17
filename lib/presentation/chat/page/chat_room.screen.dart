import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              case Status.success:
                return const _ChatRoomView();
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
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

  _handleSend() async {
    context.read<ChatRoomBloc>().add(SendMessage(content: _tec.text));
    _tec.clear();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(
            context.read<ChatRoomBloc>().state.opponent.username ?? "Unknown"),
      ),
      body: Column(
        children: [
          Expanded(
              child: _MessageList(context.read<ChatRoomBloc>().state.stream!)),
          TextField(
            controller: _tec,
            decoration: InputDecoration(
                suffixIcon: IconButton(
              onPressed: _handleSend,
              icon: Icon(Icons.send),
            )),
          )
        ],
      ));
}

class _MessageList extends StatefulWidget {
  const _MessageList(this.stream, {super.key});

  final Stream<List<MessageEntity>> stream;

  @override
  State<_MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<_MessageList> {
  final ScrollController _sc = ScrollController();

  _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sc.animateTo(
        _sc.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  dispose() {
    super.dispose();
    _sc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MessageEntity>>(
      stream: widget.stream,
      builder: (_, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data;
        _jumpToBottom();
        return ListView.builder(
            controller: _sc,
            shrinkWrap: true,
            itemCount: data?.length ?? 0,
            itemBuilder: (_, index) => MessageItem(data![index]));
      },
    );
  }
}
