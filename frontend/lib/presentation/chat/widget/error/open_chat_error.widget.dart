import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/chat/bloc/room/open_chat/open_chat.bloc.dart';

class OpenChatErrorWidget extends StatelessWidget {
  const OpenChatErrorWidget(this.message, {super.key});

  final String message;

  _handleInitFeedState(BuildContext ctx) => () {
        ctx.read<OpenChatBloc>().add(InitOpenChatEvent());
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Error", style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 15),
                Text(message,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: _handleInitFeedState(context),
                    child: const Text("이전화면으로"))
              ],
            ),
          ),
        ),
      );
}
