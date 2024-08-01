import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/domain/entity/chat/open_chat.entity.dart';
import 'package:portfolio/presentation/bloc/chat/chat.bloc_module.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../core/constant/status.dart';
import '../../../../../core/dependency_injection/configure_dependencies.dart';
import '../../../../../core/route/router.dart';
import '../../../../bloc/chat/open_chat/display/display_open_chat.cubit.dart';
import '../../../main/components/hashtags.widget.dart';
import '../../../main/components/loading.screen.dart';

part 'display_open_chat.screen.dart';

class DisplayOpenChatPage extends StatelessWidget {
  const DisplayOpenChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ChatBlocModule>().displayOpenChat,
        child: BlocBuilder<DisplayOpenChatCubit, DisplayOpenChatState>(
            builder: (context, state) {
          switch (state.status) {
            case Status.initial:
            case Status.success:
              return const DisplayOpenChatScreen();
            case Status.loading:
            case Status.error:
              return const LoadingScreen();
          }
        }));
  }
}
