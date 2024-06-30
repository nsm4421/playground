import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/dependency_injection/dependency_injection.dart';
import 'package:my_app/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:my_app/presentation/bloc/chat/chat.bloc.dart';
import 'package:my_app/presentation/bloc/chat/open_chat/display/display_open_chat.bloc.dart';
import 'package:my_app/presentation/components/error.fragment.dart';
import 'package:my_app/presentation/components/loading.fragment.dart';
import 'package:my_app/presentation/components/stream_builder.widget.dart';

import '../../../../../../core/constant/routes.dart';

part 'open_chat.screen.dart';

part 'open_chat_item.widget.dart';

class OpenChatPage extends StatelessWidget {
  const OpenChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DisplayOpenChatBloc>(
        create: (_) => getIt<ChatBloc>().displayOpenChat,
        lazy: true,
        child: BlocBuilder<DisplayOpenChatBloc, DisplayOpenChatState>(
          builder: (context, state) {
            if (state is InitialDisplayOpenChatState ||
                state is DisplayOpenChatSuccessState) {
              return const OpenChatScreen();
            } else if (state is DisplayOpenChatLoadingState) {
              return const LoadingFragment();
            } else {
              return const ErrorFragment();
            }
          },
        ));
  }
}
