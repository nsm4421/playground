import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/feed.bloc.dart';

class FeedErrorWidget extends StatelessWidget {
  const FeedErrorWidget(this.message, {super.key});

  final String message;

  _handleInitFeedState(BuildContext ctx) => () {
        ctx.read<FeedBloc>().add(InitFeedStateEvent());
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
