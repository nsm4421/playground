import 'package:flutter/material.dart';
import 'package:hot_place/data/entity/feed/comment/feed_comment.entity.dart';

import '../../../../core/util/date.util.dart';

class FeedCommentItemWidget extends StatelessWidget {
  const FeedCommentItemWidget(this._comment, {super.key, this.imageSize = 40});

  final FeedCommentEntity _comment;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // 프로필 사진
      leading: _comment.author?.profileImage == null
          ? const CircleAvatar(child: Icon(Icons.question_mark))
          : Container(
              height: imageSize,
              width: imageSize,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(_comment.author!.profileImage!),
                      fit: BoxFit.cover)),
            ),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 작성자
          if (_comment.author?.nickname != null)
            Text("${_comment.author?.nickname}",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w700)),
          const Spacer(),

          // 작성 시간
          if (_comment.createdAt != null)
            Text(DateUtil.formatTimeAgo(_comment.createdAt!),
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary))
        ],
      ),

      // 본문
      subtitle: Text(_comment.content ?? '',
          softWrap: true,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600)),
    );
  }
}
