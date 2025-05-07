import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:portfolio/presentation/bloc/auth/auth.bloc.dart';
import 'package:portfolio/domain/entity/chat/open_chat.entity.dart';
import 'package:portfolio/presentation/bloc/chat/chat.bloc_module.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/constant/status.dart';
import '../../../../../core/dependency_injection/configure_dependencies.dart';
import '../../../../bloc/chat/open_chat/chat_room/open_chat_room.bloc.dart';
import '../../components/open_chat_message_item.widget.dart';

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
