import '../../../core/constant/constant.dart';
import '../../../data/model/comment/fetch_comment.dart';
import '../auth/presence.dart';

class CommentEntity extends BaseEntity {
  final String? referenceId;
  final String? referenceTable;
  final PresenceEntity? author;
  final String? content;

  CommentEntity(
      {super.id,
      super.createdAt,
      super.updatedAt,
      super.createdBy,
      this.referenceId,
      this.referenceTable,
      this.author,
      this.content});

  factory CommentEntity.from(FetchCommentModel model) {
    return CommentEntity(
      id: model.id.isNotEmpty ? model.id : null,
      createdAt: DateTime.tryParse(model.created_at),
      updatedAt: DateTime.tryParse(model.updated_at),
      createdBy: model.author_uid,
      referenceId:
          model.refererence_id.isNotEmpty ? model.refererence_id : null,
      referenceTable:
          model.refererence_table.isNotEmpty ? model.refererence_table : null,
      author: model.author_uid.isNotEmpty
          ? PresenceEntity(
              uid: model.author_uid,
              username: model.author_username,
              avatarUrl: model.author_avatar_url)
          : null,
      content: model.content.isNotEmpty ? model.content : null,
    );
  }
}
