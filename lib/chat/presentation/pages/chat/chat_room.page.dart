import 'package:flutter/material.dart';
import 'package:flutter_app/auth/auth.export.dart';
import 'package:flutter_app/chat/domain/entity/chat.entity.dart';
import 'package:flutter_app/chat/presentation/bloc/message/chat_message.bloc.dart';
import 'package:flutter_app/shared/config/config.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_room.screen.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage(this._chat, {super.key});

  final ChatEntity _chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ChatMessageBloc>(
              param1: _chat,
              param2: context.read<AuthenticationBloc>().presence,
            ),
        child: BlocBuilder<ChatMessageBloc, ChatMessageState>(
          builder: (context, state) {
            return ChatRoomScreen();
          },
        ));
  }
}
