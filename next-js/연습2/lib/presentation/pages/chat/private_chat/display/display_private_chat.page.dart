import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/core/util/date.util.dart';
import 'package:portfolio/presentation/bloc/chat/chat.bloc_module.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/constant/status.dart';
import '../../../../../core/dependency_injection/configure_dependencies.dart';
import '../../../../../core/route/router.dart';
import '../../../../bloc/chat/private_chat/display/display_private_chat.bloc.dart';
import '../../../main/components/error.screen.dart';
import '../../../main/components/loading.screen.dart';

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
