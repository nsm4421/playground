import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/auth/domain/entity/presence.entity.dart';
import 'package:portfolio/features/auth/presentation/bloc/auth.bloc.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat.entity.dart';
import 'package:portfolio/features/chat/presentation/bloc/chat.bloc_module.dart';
import 'package:portfolio/features/chat/presentation/bloc/chat_room/open_chat_room.bloc.dart';
import 'package:portfolio/features/chat/presentation/pages/components/message_item.widget.dart';
import 'package:portfolio/features/main/core/dependency_injection/configure_dependencies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../main/core/constant/status.dart';

part "open_chat_room.screen.dart";

part "open_chat_room_text_field.widget.dart";

part "open_chat_message_list.fragment.dart";

part "presence_list.fragment.dart";

part 'fetch_more_button.widget.dart';

class OpenChatRoomPage extends StatelessWidget {
  const OpenChatRoomPage(this._chat, {super.key});

  final OpenChatEntity _chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatBlocModule>().openChatRoom(_chat.id!)
        ..add(InitOpenChatRoomEvent()),
      child: OpenChatRoomScreen(_chat),
    );
  }
}
