import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/bloc/chat/chat.bloc.dart';
import 'package:my_app/presentation/bloc/chat/open_chat/create/create_open_chat.cubit.dart';
import 'package:my_app/presentation/bloc/chat/open_chat/create/create_open_chat.state.dart';

import '../../../../../../core/constant/status.dart';
import '../../../../../../core/dependency_injection/dependency_injection.dart';
import '../../../../../components/error.fragment.dart';
import '../../../../../components/loading.fragment.dart';

part 'create_open_chat.screen.dart';

class CreateOpenChatPage extends StatelessWidget {
  const CreateOpenChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateOpenChatCubit>(
        create: (_) => getIt<ChatBloc>().createOpenChat,
        lazy: true,
        child: BlocListener<CreateOpenChatCubit, CreateOpenChatState>(
          listenWhen: (prev, curr) =>
              (prev.status == Status.loading) &&
              (curr.status == Status.success),
          listener: (BuildContext context, CreateOpenChatState state) {
            if (state.status == Status.success && context.mounted) {
              context.pop();
            }
          },
          child: BlocBuilder<CreateOpenChatCubit, CreateOpenChatState>(
            builder: (context, state) {
              switch (state.status) {
                case Status.initial:
                case Status.success:
                  return const CreateOpenChatScreen();
                case Status.loading:
                  return const LoadingFragment();
                case Status.error:
                  return const ErrorFragment();
              }
            },
          ),
        ));
  }
}
