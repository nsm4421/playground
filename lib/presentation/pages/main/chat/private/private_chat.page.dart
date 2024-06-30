import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/data/entity/chat/chat_message/private_chat_message.entity.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/presentation/bloc/chat/chat.bloc.dart';
import 'package:my_app/presentation/bloc/chat/private_chat_message/display/display_private_chat_message.bloc.dart';
import 'package:my_app/presentation/bloc/chat/private_chat_message/create/send_private_chat_message.cubit.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';
import 'package:my_app/presentation/components/user/avatar.widget.dart';
import '../../../../../core/constant/status.dart';
import '../../../../../core/util/toast.util.dart';
import '../../../../bloc/chat/private_chat_message/create/send_private_chat_message.state.dart';

part 'private_chat_room.screen.dart';

part 'private_chat_text_field_widget.widget.dart';
part 'private_chat_message_item.widget.dart';

class PrivateChatPage extends StatelessWidget {
  const PrivateChatPage(this._opponent, {super.key});

  final AccountEntity _opponent;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<DisplayPrivateChatMessageBloc>(
              create: (_) => getIt<ChatBloc>().displayPrivateChat
                ..add(FetchPrivateMessagesEvent(_opponent)),
              lazy: true),
          BlocProvider<SendPrivateChatMessageCubit>(
              create: (_) => getIt<ChatBloc>().sendPrivateChat, lazy: true),
        ],
        child: BlocBuilder<DisplayPrivateChatMessageBloc,
            DisplayPrivateChatMessageState>(
          builder: (context, state) {
            if (state is InitialPrivateChatMessageState ||
                state is PrivateChatMessageSuccessState) {
              return PrivateChatRoomScreen(_opponent);
            } else if (state is PrivateChatMessageLoadingState) {
              return const LoadingFragment();
            } else {
              return const ErrorFragment();
            }
          },
        ));
  }
}
