import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/util/time_diff.util.dart';
import '../../domain/model/feed/feed.model.dart';
import '../home/bloc/auth.bloc.dart';

class FeedItemWidget extends StatelessWidget {
  const FeedItemWidget(this.feed, {super.key});

  final FeedModel feed;

  // TODO : 이벤트 등록
  _handleClickMoreIcon() {}

  _handleClickLikeIcon() {}

  _handleClickChatIcon() {}

  _handleClickRepeatIcon() {}

  _handleClickSendIcon() {}

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Row(
              children: [
                // profile image
                const SizedBox(
                  width: 40,
                  child:
                      CircleAvatar(child: Icon(Icons.account_circle_outlined)),
                ),
                const SizedBox(width: 8),

                // nickname
                Text(context.read<AuthBloc>().state.nickname,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(width: 10),

                // created at
                if (feed.createdAt != null)
                  Text(TimeDiffUtil.getTimeDiffRep(feed.createdAt!),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary)),
                const Spacer(),

                // more icon
                IconButton(
                    onPressed: _handleClickMoreIcon,
                    icon: Icon(Icons.more_vert,
                        color: Theme.of(context).colorScheme.tertiary))
              ],
            ),
            const SizedBox(height: 10),

            // content
            Row(
              children: [
                const SizedBox(width: 50),
                Text(feed.content ?? '',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            const SizedBox(height: 10),

            // icons
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                IconButton(
                    onPressed: _handleClickLikeIcon,
                    icon: Icon(
                      Icons.favorite_outline,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                IconButton(
                    onPressed: _handleClickChatIcon,
                    icon: Icon(Icons.chat_bubble_outline,
                        color: Theme.of(context).colorScheme.secondary)),
                IconButton(
                    onPressed: _handleClickRepeatIcon,
                    icon: Icon(Icons.repeat,
                        color: Theme.of(context).colorScheme.secondary)),
                IconButton(
                    onPressed: _handleClickSendIcon,
                    icon: Icon(Icons.send,
                        color: Theme.of(context).colorScheme.secondary)),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(indent: 18, endIndent: 18, thickness: 0.5),
            const SizedBox(height: 5),
          ],
        ),
      );
}
