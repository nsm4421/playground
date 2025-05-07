part of '../../../export.pages.dart';

class CommentItemWidget extends StatelessWidget {
  const CommentItemWidget(this._comment, {super.key});

  final CommentEntity _comment;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomCircleAvatarWidget(_comment.author.profileImage),
      title: Text(
        _comment.author.nickname,
        style: context.textTheme.labelLarge
            ?.copyWith(overflow: TextOverflow.clip, color: Colors.blueGrey),
        softWrap: true,
        overflow: TextOverflow.clip,
      ),
      subtitle: Text(
        _comment.content,
        style:
            context.textTheme.bodyLarge?.copyWith(overflow: TextOverflow.clip),
        softWrap: true,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
