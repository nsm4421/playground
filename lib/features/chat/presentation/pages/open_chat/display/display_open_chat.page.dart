import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat.entity.dart';
import 'package:portfolio/features/chat/presentation/bloc/chat.bloc_module.dart';
import 'package:portfolio/features/chat/presentation/bloc/open_chat/display/display_open_chat.cubit.dart';
import 'package:portfolio/features/main/presentation/components/hashtags.widget.dart';
import 'package:portfolio/features/main/presentation/components/loading.screen.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../main/core/constant/status.dart';
import '../../../../../main/core/dependency_injection/configure_dependencies.dart';
import '../../../../../main/core/route/router.dart';

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
