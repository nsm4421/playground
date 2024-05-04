import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';
import 'package:hot_place/data/entity/feed/like/like_feed.entity.dart';
import 'package:hot_place/presentation/feed/bloc/base/feed.bloc.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';

class FavoriteIconWidget extends StatefulWidget {
  const FavoriteIconWidget(this.feed, {super.key});

  final FeedEntity feed;

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  _handleLike() {
    context.read<FeedBloc>().add(LikeFeedEvent(
        feed: widget.feed, currentUser: context.read<UserBloc>().state.user));
  }

  _handleCancelLike() {
    context.read<FeedBloc>().add(CancelLikeFeedEvent(
        feed: widget.feed, currentUser: context.read<UserBloc>().state.user));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Iterable<LikeFeedEntity>>(
        stream: context.read<FeedBloc>().likeFeedStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            bool isLike = false;
            var data = snapshot.data ?? [];
            for (final like in data) {
              if (like.feedId == widget.feed.id) {
                isLike = true;
                break;
              }
            }

            return IconButton(
              onPressed: isLike ? _handleCancelLike : _handleLike,
              icon: isLike
                  ? Icon(Icons.favorite,
                      color: Theme.of(context).colorScheme.primary)
                  : Icon(Icons.favorite_border,
                      color: Theme.of(context).colorScheme.primary),
            );
          }

          // 로딩중
          return Icon(Icons.favorite_border,
              color: Theme.of(context).colorScheme.secondary);
        });
  }
}
