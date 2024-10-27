import '../../../core/constant/constant.dart';
import '../../../data/model/diary/fetch_diary.dart';
import '../auth/presence.dart';

class DiaryEntity extends BaseEntity {
  final String? location;
  final String? content;
  late final List<String> hashtags;
  late final List<String?> images;
  late final List<String?> captions;
  final bool isPrivate;
  final bool isLike;
  final int likeCount;
  final int commentCount;
  final PresenceEntity? author;

  DiaryEntity(
      {super.id,
      super.createdAt,
      super.updatedAt,
      super.createdBy,
      this.location,
      this.content,
      List<String>? hashtags,
      List<String?>? images,
      List<String?>? captions,
      this.isPrivate = false,
      this.isLike = false,
      this.likeCount = 0,
      this.commentCount = 0,
      this.author}) {
    this.hashtags = hashtags ?? [];
    this.images = images ?? [];
    this.captions = captions ?? [];
  }

  factory DiaryEntity.from(FetchDiaryModel model) => DiaryEntity(
      id: model.id.isNotEmpty ? model.id : null,
      location: model.location,
      content: model.content,
      hashtags: model.hashtags.where((item) => item.isNotEmpty).toList(),
      images:
          model.images.map((item) => item.isNotEmpty ? item : null).toList(),
      captions:
          model.captions.map((item) => item.isNotEmpty ? item : null).toList(),
      isPrivate: model.is_private,
      isLike: model.is_like,
      likeCount: model.like_count,
      commentCount: model.comment_count,
      createdAt: DateTime.tryParse(model.created_at),
      updatedAt: DateTime.tryParse(model.updated_at),
      createdBy: model.created_by,
      author: model.created_by.isNotEmpty
          ? PresenceEntity(
              uid: model.created_by,
              username: model.username,
              avatarUrl: model.avatar_url)
          : null);

  int get length => images.length;
}
