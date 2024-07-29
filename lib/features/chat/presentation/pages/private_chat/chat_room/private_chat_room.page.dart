import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/auth/domain/entity/presence.entity.dart';
import 'package:portfolio/features/auth/presentation/bloc/auth.bloc.dart';
import 'package:portfolio/features/chat/presentation/bloc/chat.bloc_module.dart';
import 'package:portfolio/features/chat/presentation/bloc/private_chat/chat_room/private_chat_room.bloc.dart';
import 'package:portfolio/features/main/core/dependency_injection/configure_dependencies.dart';

part "private_chat_room.screen.dart";

class PrivateChatRoomPage extends StatefulWidget {
  const PrivateChatRoomPage(this.receiver, {super.key});

  final PresenceEntity receiver;

  @override
  State<PrivateChatRoomPage> createState() => _PrivateChatRoomPageState();
}

class _PrivateChatRoomPageState extends State<PrivateChatRoomPage> {
  late String _chatId;

  @override
  void initState() {
    super.initState();
    final currentUid = context.read<AuthBloc>().currentUser!.id;
    _chatId = ({currentUid, widget.receiver.id}.toList()..sort()).join("_");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ChatBlocModule>().privateChatRoom(_chatId)
          ..add(FetchPrivateChatMessageEvent()),
        child:
            PrivateChatRoomScreen(chatId: _chatId, receiver: widget.receiver));
  }
}
