import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/presentation/chat/bloc/message/private_chat/private_chat_message.bloc.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';

import '../../../../data/entity/chat/private_chat/message/private_chat_message.entity.dart';
import '../../bloc/chat_bloc.module.dart';
import '../../bloc/message/open_chat/open_chat_message.bloc.dart';
import '../../widget/private_chat/private_chat_message_item.widget.dart';

class PrivateChatRoomScreen extends StatelessWidget {
  const PrivateChatRoomScreen(
      {super.key, required String chatId, required UserEntity receiver})
      : _chatId = chatId,
        _receiver = receiver;

  final String _chatId;
  final UserEntity _receiver;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatBlocModule>().privateChatMessageBloc(_chatId)
        ..add(InitPrivateChatMessageEvent()),
      child: BlocConsumer<PrivateChatMessageBloc, PrivateChatMessageState>(
        builder: (BuildContext context, PrivateChatMessageState state) {
          if (state is InitialPrivateChatMessageState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrivateChatMessageFailureState) {
            return const Center(child: Text("ERROR"));
          }
          return _View(chatId: _chatId, receiver: _receiver);
        },
        listener: (BuildContext context, PrivateChatMessageState state) {
          if (state is PrivateChatMessageFailureState) {
            ToastUtil.toast(state.message);
            context
                .read<PrivateChatMessageBloc>()
                .add(InitPrivateChatMessageEvent());
          }
        },
      ),
    );
  }
}

class _View extends StatefulWidget {
  const _View({super.key, required this.chatId, required this.receiver});

  final String chatId;
  final UserEntity receiver;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  late ScrollController _scrollController;
  late TextEditingController _textEditingController;
  late UserEntity _currentUser;
  late StreamSubscription<List<PrivateChatMessageEntity>> _subscription;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_scrollToBottom);
    _currentUser = context.read<UserBloc>().state.user;
    _subscription =
        context.read<PrivateChatMessageBloc>().messageStream.listen((event) {
      context
          .read<PrivateChatMessageBloc>()
          .add(NewPrivateChatMessageEvent(event));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.removeListener(_scrollToBottom);
    _textEditingController.dispose();
    _scrollController.dispose();
    _subscription.cancel();
  }

  _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  _handleSendMessage() async {
    context.read<PrivateChatMessageBloc>().add(SendPrivateChatMessageEvent(
        chatId: widget.chatId,
        content: _textEditingController.text.trim(),
        currentUser: _currentUser,
        receiver: widget.receiver));
    _textEditingController.clear();
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.read<PrivateChatMessageBloc>().state
        is OpenChatMessageLoadingState;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<PrivateChatMessageEntity>>(
                stream: context.read<PrivateChatMessageBloc>().messageStream,
                initialData: context.read<PrivateChatMessageBloc>().messages,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data ?? [];
                    return ListView.builder(
                        controller: _scrollController,
                        itemCount: data.length,
                        itemBuilder: (_, index) {
                          final message = data[index];
                          return PrivateChatMessageItemWidget(
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
