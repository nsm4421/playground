import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/util/time_diff.util.dart';
import '../../domain/model/feed/feed.model.dart';
import '../home/bloc/auth.bloc.dart';

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget(this.feed, {super.key});

  final FeedModel feed;

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  late CarouselController _controller;
  late int _currentPage;

  static const double _horizontalPadding = 10;
  static const double _circularAvatarSize = 40;

  @override
  initState() {
    super.initState();
    _controller = CarouselController();
    _currentPage = 0;
  }

  // TODO : 이벤트 등록
  _handleClickMoreIcon() {}

  _handleClickLikeIcon() {}

  _handleClickChatIcon() {}

  _handleClickRepeatIcon() {}

  _handleClickSendIcon() {}

  _handleAnimateToPage(int page) => () => setState(() {
        _controller.animateToPage(page,
            duration: const Duration(milliseconds: 200));
        _currentPage = page;
      });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            children: [
              const SizedBox(width: _horizontalPadding),

              // profile image
              const SizedBox(
                width: _circularAvatarSize,
                child: CircleAvatar(child: Icon(Icons.account_circle_outlined)),
              ),
              const SizedBox(width: 8),

              // nickname
              Text(context.read<AuthBloc>().state.nickname,
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
              const SizedBox(width: _horizontalPadding)
            ],
          ),
          const SizedBox(height: 5),
          const Divider(indent: 18, endIndent: 18, thickness: 0.5),
          const SizedBox(height: 5),
        ],
      );
}
