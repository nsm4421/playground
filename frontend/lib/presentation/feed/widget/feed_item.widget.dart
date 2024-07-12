import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';
import 'package:hot_place/presentation/feed/widget/favorite_icon.widget.dart';
import 'package:hot_place/presentation/feed/page/comment/feed_comment_icon.widget.dart';
import 'package:hot_place/presentation/feed/widget/hashtag_list.widget.dart';
import 'package:hot_place/presentation/setting/widget/profile_image.widget.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                // 프로필 사진
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 15),
                  child: ProfileImageWidget(
                    widget._feed.user.profileImage,
                    radius: 20,
                  ),
                ),

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
          ),

          // 이미지
          if (widget._feed.images.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FeedImageCarouselWidget(widget._feed.images),
            ),

          // 본문
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 15),
            child: Text(widget._feed.content ?? '',
                overflow: TextOverflow.clip,
                softWrap: true,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
          ),

          // 해시태그
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: HashtagListWidget(widget._feed.hashtags),
          ),

          // 아이콘 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 좋아요 아이콘 버튼
              Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: FavoriteIconWidget(widget._feed)),

              // 댓글 아이콘 버튼
              Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: FeedCommentIconWidget(widget._feed))
            ],
          )
        ],
      ),
    );
  }
}
