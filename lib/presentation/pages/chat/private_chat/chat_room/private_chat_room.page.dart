import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:portfolio/presentation/bloc/auth/auth.bloc.dart';
import 'package:portfolio/presentation/bloc/chat/chat.bloc_module.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/status.dart';
import '../../../../../core/dependency_injection/configure_dependencies.dart';
import '../../../../bloc/chat/private_chat/chat_room/private_chat_room.bloc.dart';
import '../../components/private_chat_message_item.widget.dart';

part "private_chat_room.screen.dart";

part "private_chat_room_text_field.widget.dart";

part "private_chat_message_list.fragment.dart";

part "fetch_more_button.widget.dart";

class PrivateChatRoomPage extends StatefulWidget {
  const PrivateChatRoomPage(this.opponent, {super.key});

  final PresenceEntity opponent;

  @override
  State<PrivateChatRoomPage> createState() => _PrivateChatRoomPageState();
}

class _PrivateChatRoomPageState extends State<PrivateChatRoomPage> {
  late String _chatId;

  @override
  void initState() {
    super.initState();
    final currentUid = context.read<AuthBloc>().currentUser!.id;
    _chatId = ({currentUid, widget.opponent.id}.toList()..sort()).join("_");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ChatBlocModule>().privateChatRoom(_chatId)
          ..add(FetchPrivateChatMessageEvent()),
        child:
            PrivateChatRoomScreen(chatId: _chatId, opponent: widget.opponent));
  }
}
