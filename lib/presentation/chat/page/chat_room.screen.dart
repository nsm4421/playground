import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';

import '../bloc/chat_bloc.module.dart';
import '../bloc/message/chat_message.bloc.dart';
import '../widget/message_item.widget.dart';

class ChatRoomScreen extends StatelessWidget {
  const ChatRoomScreen(this._chatId, {super.key});

  final String _chatId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatBlocModule>().chatMessageBloc(_chatId),
      child: BlocConsumer<ChatMessageBloc, ChatMessageState>(
        builder: (BuildContext context, ChatMessageState state) {
          return _View(_chatId);
        },
        listener: (BuildContext context, ChatMessageState state) {
          if (state is ChatMessageFailureState) {
            ToastUtil.toast(state.message);
            context.read<ChatMessageBloc>().add(InitChatMessageEvent());
          }
        },
      ),
    );
  }
}

class _View extends StatefulWidget {
  const _View(this.chatId, {super.key});

  final String chatId;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  late Stream<List<ChatMessageEntity>> _chatMessageStream;
  late ScrollController _scrollController;
  late TextEditingController _textEditingController;
  late UserEntity _currentUser;

  @override
  void initState() {
    super.initState();
    _chatMessageStream = context.read<ChatMessageBloc>().messageStream;
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_scrollToBottom);
    _currentUser = context.read<UserBloc>().state.user;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.removeListener(_scrollToBottom);
    _textEditingController.dispose();
    _scrollController.dispose();
  }

  _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  _handleSendMessage() async {
    context.read<ChatMessageBloc>().add(SendChatMessageEvent(
        chatId: widget.chatId,
        content: _textEditingController.text.trim(),
        currentUser: _currentUser));
    _textEditingController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading =
        context.read<ChatMessageBloc>().state is ChatMessageLoadingState;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessageEntity>>(
                stream: _chatMessageStream,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data ?? [];
                    return ListView.builder(
                        controller: _scrollController,
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          final message = data[index];
                          return MessageItemWidget(
                              chatMessage: message, currentUser: _currentUser);
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("ERROR",
                            style: Theme.of(context).textTheme.displayLarge));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),

          // 메세지 입력
          TextField(
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(decorationThickness: 0),
            controller: _textEditingController,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),

                // 전송 버튼
                suffixIcon: IconButton(
                  onPressed: isLoading ? null : _handleSendMessage,
                  icon: Icon(
                    Icons.send,
                    color: isLoading
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
