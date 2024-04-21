import 'package:flutter/material.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';
import 'package:hot_place/presentation/feed/page/comment/feed_comment.screen.dart';
import 'package:hot_place/presentation/feed/widget/hashtag_list.widget.dart';

import '../../../core/util/date.util.dart';
import 'feed_image_carousel.widget.dart';

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  static const double _profileImageSize = 40;

  _handleShowComment() => WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => FeedCommentScreen(widget._feed));
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              // 프로필 사진
              if (widget._feed.user.profileImage != null)
                Container(
                    width: _profileImageSize,
                    height: _profileImageSize,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                widget._feed.user.profileImage!)))),
              if (widget._feed.user.profileImage == null)
                const SizedBox(
                    width: _profileImageSize,
                    height: _profileImageSize,
                    child: CircleAvatar(child: Icon(Icons.account_circle))),
              const SizedBox(width: 15),

              // 닉네임
              Text(widget._feed.user.nickname ?? "Unknown",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold)),
              const Spacer(),

              // 작성시간
              if (widget._feed.createdAt != null)
                Text(DateUtil.formatTimeAgo(widget._feed.createdAt!),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary))
            ],
          ),
          const SizedBox(height: 15),

          // 이미지
          if (widget._feed.images.isNotEmpty)
            FeedImageCarouselWidget(widget._feed.images),
          const SizedBox(height: 20),

          // 본문
          Row(
            children: [
              const SizedBox(width: 10),
              Text(widget._feed.content ?? '',
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer))
            ],
          ),
          const SizedBox(height: 20),

          // 해시태그
          HashtagListWidget(widget._feed.hashtags),
          const SizedBox(height: 20),

          // 아이콘
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: IconButton(
                    onPressed: _handleShowComment,
                    icon: const Icon(Icons.comment_outlined),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
