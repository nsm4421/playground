import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/data/entity/chat/chat_message/private_chat_message.entity.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/presentation/bloc/chat/chat.bloc.dart';
import 'package:my_app/presentation/bloc/chat/private_chat_message/display/display_private_chat_message.bloc.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';
import 'package:my_app/presentation/pages/main/chat/private/private_chat.page.dart';

import '../../../../../core/constant/routes.dart';
import '../../../../../core/util/time.util.dart';

part 'chat.screen.dart';

part 'private_chat_item.widget.dart';

part 'private_chat_list.fragment.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisplayPrivateChatMessageBloc>(
        create: (_) => getIt<ChatBloc>().displayPrivateChat
          ..add(FetchLatestPrivateMessagesEvent()),
        child: BlocBuilder<DisplayPrivateChatMessageBloc,
            DisplayPrivateChatMessageState>(builder: (context, state) {
          if (state is InitialPrivateChatMessageState ||
              state is PrivateChatMessageSuccessState) {
            return const ChatScreen();
          } else if (state is PrivateChatMessageFailureState) {
            return const ErrorFragment();
          } else {
            return const LoadingFragment();
          }
        }));
  }
}
