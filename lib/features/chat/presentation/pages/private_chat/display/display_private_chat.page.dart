import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/features/chat/presentation/bloc/chat.bloc_module.dart';
import 'package:portfolio/features/chat/presentation/bloc/private_chat/display/display_private_chat.bloc.dart';
import 'package:portfolio/features/main/core/dependency_injection/configure_dependencies.dart';
import 'package:portfolio/features/main/core/route/router.dart';
import 'package:portfolio/features/main/presentation/components/error.screen.dart';
import 'package:portfolio/features/main/presentation/components/loading.screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../main/core/constant/status.dart';

part "display_private_chat.screen.dart";

part "last_private_chat_list.fragment.dart";

class DisplayPrivateChatPage extends StatelessWidget {
  const DisplayPrivateChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ChatBlocModule>().displayPrivateChat
          ..add(FetchPrivateChatEvent()),
        child: BlocBuilder<DisplayPrivateChatBloc, DisplayPrivateChatState>(
            builder: (context, state) {
          switch (state.status) {
            case Status.initial:
            case Status.success:
              return const PrivateChatScreen();
            case Status.loading:
              return const LoadingScreen();
            case Status.error:
              return const ErrorScreen();
          }
        }));
  }
}
