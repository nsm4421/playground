import 'package:my_app/data/dto/feed/feed.dto.dart';

import '../../domain/model/feed/feed.model.dart';

extension FeedDtoEx on FeedDto {
  toModel() => FeedModel(
      feedId: feedId ?? '',
      content: content ?? '',
      hashtags: hashtags ?? [],
      images: images ?? [],
      uid: uid ?? '',
      createdAt: createdAt);
}
