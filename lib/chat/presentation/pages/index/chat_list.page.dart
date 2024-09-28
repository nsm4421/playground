import 'package:flutter/material.dart';
import 'package:flutter_app/chat/presentation/bloc/chat/chat.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_list.screen.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(FetchChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: (context, state) {
      return ChatListScreen();
    });
  }
}
