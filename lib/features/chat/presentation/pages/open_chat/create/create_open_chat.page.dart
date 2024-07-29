import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/chat/presentation/bloc/chat.bloc_module.dart';
import 'package:portfolio/features/chat/presentation/bloc/open_chat/create/create_open_chat.cubit.dart';
import 'package:portfolio/features/main/core/dependency_injection/configure_dependencies.dart';
import 'package:portfolio/features/main/presentation/components/hashtags.widget.dart';
import 'package:portfolio/features/main/presentation/components/loading.screen.dart';

import '../../../../../main/core/constant/status.dart';

part 'create_open_chat.screen.dart';

class CreateOpenChatPage extends StatelessWidget {
  const CreateOpenChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ChatBlocModule>().createOpenChat,
        child: BlocListener<CreateOpenChatCubit, CreateOpenChatState>(
          listener: (BuildContext context, ChatState state) {
            if (state.status == Status.success && context.mounted) {
              // 성공 시 1초 뒤 뒤로가기
              Timer(const Duration(seconds: 1), () {
                context.pop();
                Fluttertoast.showToast(msg: "Chat Created");
              });
            } else if (state.status == Status.error) {
              // 에러발생시 1초 뒤 다시 작성 양식 페이지로 이동
              Timer(const Duration(seconds: 1), () {
                context.read<CreateOpenChatCubit>().initStatus();
                Fluttertoast.showToast(msg: "Error Occurs");
              });
            }
          },
          child: BlocBuilder<CreateOpenChatCubit, CreateOpenChatState>(
            builder: (BuildContext context, ChatState state) {
              switch (state.status) {
                case Status.initial:
                  return const CreateOpenChatScreen();
                case Status.loading:
                case Status.success:
                case Status.error:
                  return const LoadingScreen();
              }
            },
          ),
        ));
  }
}
