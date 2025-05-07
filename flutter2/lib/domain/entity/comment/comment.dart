import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/data/model/comment/fetch.dart';
import 'package:travel/domain/entity/auth/presence.dart';

class CommentEntity extends BaseEntity {
  final String? parentId;
  final String referenceId;
  final String referenceTable;
  final String content;
  final PresenceEntity author;
  final int childCount;
  final bool isLike;
  final int likeCount;

  CommentEntity(
      {super.id,
      super.createdAt,
      super.updatedAt,
      this.parentId,
      required this.referenceId,
      required this.referenceTable,
      required this.content,
      required this.author,
      this.childCount = 0,
      this.isLike = false,
      this.likeCount = 0});

  factory CommentEntity.from(FetchCommentDto dto) {
    return CommentEntity(
        id: dto.id,
        createdAt: DateTime.tryParse(dto.created_at),
        updatedAt: DateTime.tryParse(dto.updated_at),
        parentId: dto.parent_id,
        referenceId: dto.reference_id,
        referenceTable: dto.reference_table,
        content: dto.content,
        author: PresenceEntity(
          id: dto.author_id,
          username: dto.author_username,
          avatarUrl: dto.author_avatar_url,
        ),
        isLike: dto.is_like,
        likeCount: dto.like_count,
        childCount: dto.child_count);
  }

  @override
  Tables get table => Tables.comments;
}
