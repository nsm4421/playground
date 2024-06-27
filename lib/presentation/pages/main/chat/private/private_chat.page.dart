import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/presentation/bloc/chat/chat.bloc.dart';
import 'package:my_app/presentation/bloc/chat/send_private_chat_message/send_private_chat_message.cubit.dart';
import 'package:my_app/presentation/components/user/avatar.widget.dart';

import '../../../../../core/constant/status.dart';
import '../../../../../core/util/toast.util.dart';
import '../../../../bloc/chat/send_private_chat_message/send_private_chat_message.state.dart';

part 'private_chat.screen.dart';

part 'private_chat_text_field_widget.widget.dart';

class PrivateChatPage extends StatelessWidget {
  const PrivateChatPage(this._opponent, {super.key});

  final AccountEntity _opponent;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendPrivateChatMessageCubit>(
        create: (_) => getIt<ChatBloc>().sendPrivateChat,
        lazy: true,
        child: BlocBuilder<SendPrivateChatMessageCubit,
            SendPrivateChatMessageState>(builder: (context, state) {
          return PrivateChatScreen(_opponent);
        }));
  }
}
