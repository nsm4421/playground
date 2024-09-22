import 'package:flutter/material.dart';
import 'package:flutter_app/feed/domain/entity/feed_comment.entity.dart';

import '../../../shared/shared.export.dart';

class CommentListTile extends StatefulWidget {
  const CommentListTile(
      {super.key,
      required this.avatarUrl,
      required this.content,
      required this.createdAt,
      required this.timeFormatter,
      this.onTap,
      this.trailing});

  final String avatarUrl;
  final String content;
  final DateTime createdAt;
  final CustomTimeFormat timeFormatter;
  final void Function()? onTap;
  final Widget? trailing;

  @override
  State<CommentListTile> createState() => _CommentListTileState();
}

class _CommentListTileState extends State<CommentListTile> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTap,
      leading: CircularAvatarImageWidget(widget.avatarUrl),
      title: Text(widget.content, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(
        widget.timeFormatter.timeAgo(widget.createdAt.toString()),
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
      ),
      trailing: widget.trailing,
    );
  }
}
