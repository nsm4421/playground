import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/data/entity/chat/base/chat.entity.dart';
import 'package:my_app/presentation/bloc/chat/message/message.bloc.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/stream_builder.widget.dart';

import '../../../../../data/entity/chat/message/chat_message.entity.dart';

part 'chat_room.screen.dart';

part 'message_item.widget.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage(this._chat, {super.key});

  final ChatEntity _chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<MessageBloc>(param1: _chat),
        child: BlocBuilder<MessageBloc, MessageState>(
            builder: (BuildContext context, MessageState state) {
          if (state is MessageFailureState) {
            return const ErrorFragment();
          }
          return ChatRoomScreen(_chat);
        }));
  }
}
