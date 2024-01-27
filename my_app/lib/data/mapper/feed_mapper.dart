import 'package:my_app/data/dto/feed/feed.dto.dart';
import 'package:my_app/data/dto/feed/feed_comment.dto.dart';
import 'package:my_app/domain/model/feed/feed_comment.model.dart';

import '../../domain/model/feed/feed.model.dart';

extension FeedDtoEx on FeedDto {
  FeedModel toModel() => FeedModel(
      feedId: feedId ?? '',
      content: content ?? '',
      hashtags: hashtags ?? [],
      images: images ?? [],
      uid: uid ?? '',
      createdAt: createdAt);
}

extension FeedCommentDtoEx on FeedCommentDto {
  FeedCommentModel toModel() => FeedCommentModel(
        feedId: feedId ?? '',
        uid: uid ?? '',
        commentId: commentId ?? '',
        content: content ?? '',
        createdAt: createdAt,
      );
}
