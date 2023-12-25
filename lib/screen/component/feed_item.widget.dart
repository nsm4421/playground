import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/api/feed/feed.api.dart';
import 'package:my_app/configurations.dart';
import 'package:my_app/domain/model/feed/parent_feed_comment.model.dart';
import 'package:my_app/domain/model/user/user.model.dart';
import 'package:my_app/repository/chat/chat.repository.dart';
import 'package:my_app/screen/home/bloc/auth.bloc.dart';
import 'package:my_app/screen/home/chat/chat_room.screen.dart';

import '../../core/util/time_diff.util.dart';
import '../../domain/model/feed/feed.model.dart';
import '../home/feed/parent_comment.widget.dart';

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget(this.feed, {super.key});

  final FeedModel feed;

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  late CarouselController _controller;
  late Stream<bool> _likeStream;
  late Stream<List<ParentFeedCommentModel>> _commentStream;

  static const double _horizontalPadding = 10;
  static const double _circularAvatarSize = 40;

  @override
  initState() {
    super.initState();
    _controller = CarouselController();
    _likeStream = getIt<FeedApi>().getLikeStream(widget.feed.fid!);
    _commentStream = getIt<FeedApi>().getParentCommentStream(widget.feed.fid!);
  }

  @override
  dispose() {
    super.dispose();
  }

  // TODO : 이벤트 등록
  _handleClickMoreIcon() {}

  _handleLike() async => await getIt<FeedApi>().likeFeed(widget.feed.fid!);

  _handleDislike() async =>
      await getIt<FeedApi>().dislikeFeed(widget.feed.fid!);

  _handleShowCommentView() => showModalBottomSheet(
        context: context,
        elevation: 0,
        enableDrag: true,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(),
        builder: (_) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: ParentCommentWidget(widget.feed.fid!),
        ),
      );

  _handleGoToSChatScreen() async => await getIt<ChatRepository>()
      .getDirectMessageChatId(widget.feed.uid!)
      .then((res) => res.data)
      .then((chatId) => chatId == null
          ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("can't send direct message..."),
              duration: Duration(seconds: 1),
            ))
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ChatScreen(chatId))));

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            children: [
              const SizedBox(width: _horizontalPadding),

              // profile image
              SizedBox(
                width: _circularAvatarSize,
                child: CircleAvatar(
                    child: widget.feed.profileImageUrl != null
                        ? Image.network(widget.feed.profileImageUrl!)
                        : const Icon(Icons.account_circle_outlined)),
              ),
              const SizedBox(width: 8),

              // nickname
              Text(widget.feed.nickname ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary)),
              const SizedBox(width: 10),

              // created at
              if (widget.feed.createdAt != null)
                Text(TimeDiffUtil.getTimeDiffRep(widget.feed.createdAt!),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary)),
              const Spacer(),

              // more icon
              IconButton(
                  onPressed: _handleClickMoreIcon,
                  icon: Icon(Icons.more_vert,
                      color: Theme.of(context).colorScheme.tertiary)),
              const SizedBox(width: _horizontalPadding)
            ],
          ),
          const SizedBox(height: 15),

          // feed images
          if (widget.feed.images.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // carousel slider
                CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        pageSnapping: true,
                        enableInfiniteScroll: false,
                        height: MediaQuery.of(context).size.width),
                    items: widget.feed.images.map((image) {
                      return Builder(
                          builder: (_) => Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(image),
                                      fit: BoxFit.cover))));
                    }).toList()),
              ],
            ),

          // content
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: 20, horizontal: _horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // content
                Text(widget.feed.content ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer)),
                const SizedBox(height: 20),
                // hashtags
                if (widget.feed.hashtags.isNotEmpty)
                  Row(
                      children: widget.feed.hashtags
                          .map((hashtag) => Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                child: Row(
                                  children: [
                                    Icon(Icons.tag,
                                        size: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    Text(
                                      hashtag,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ],
                                ),
                              ))
                          .toList())
              ],
            ),
          ),

          // icons
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: _horizontalPadding),

              // like icon button
              StreamBuilder<bool>(
                stream: _likeStream,
                builder: (_, snapshot) => (snapshot.hasData &&
                        !snapshot.hasError)
                    ? Row(
                        children: [
                          IconButton(
                              tooltip: 'Like',
                              onPressed:
                                  snapshot.data! ? _handleDislike : _handleLike,
                              icon: Icon(
                                  snapshot.data!
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: snapshot.data!
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .tertiary)),
                          Text(widget.feed.likeCount.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary))
                        ],
                      )
                    : const SizedBox(),
              ),
              const SizedBox(width: 10),

              // comment icon
              StreamBuilder<List<ParentFeedCommentModel>>(
                  stream: _commentStream,
                  builder: (_, snapshot) =>
                      (snapshot.hasData && !snapshot.hasError)
                          ? Row(
                              children: [
                                IconButton(
                                    tooltip: 'Comment',
                                    onPressed: _handleShowCommentView,
                                    icon: Icon(Icons.chat_outlined,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                                Text((snapshot.data ?? []).length.toString())
                              ],
                            )
                          : const SizedBox()),

              const SizedBox(width: 10),

              if (context.read<AuthBloc>().state.uid != widget.feed.uid)
                IconButton(
                    tooltip: 'DM',
                    onPressed: _handleGoToSChatScreen,
                    icon: Icon(Icons.send,
                        color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(width: _horizontalPadding)
            ],
          ),
          const SizedBox(height: 5),
          const Divider(indent: 18, endIndent: 18, thickness: 0.5),
          const SizedBox(height: 5),
        ],
      );
}
