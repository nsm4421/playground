import 'package:flutter/material.dart';
import 'package:my_app/presentation/pages/feed/feed_comment/feed_comment.fragment.dart';

class FeedItemIconButtonsWidget extends StatefulWidget {
  const FeedItemIconButtonsWidget(this.feedId, {super.key});

  final String feedId;

  @override
  State<FeedItemIconButtonsWidget> createState() =>
      _FeedItemIconButtonsWidgetState();
}

class _FeedItemIconButtonsWidgetState extends State<FeedItemIconButtonsWidget> {
  _handleClickFavoriteButton() {}

  _handleClickBookMarkButton() {}

  _handleClickAddCommentButton(BuildContext context) => () {
        showModalBottomSheet(
          context: context,
          builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FeedCommentFragment(widget.feedId)),
          showDragHandle: true,
          enableDrag: true,
          isDismissible: true,
          isScrollControlled: true,
          useSafeArea: true,
          barrierColor: Colors.grey.withOpacity(0.5),
        );
      };

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 15),
          IconButton(
              onPressed: _handleClickFavoriteButton,
              icon: const Icon(Icons.favorite_outline, color: Colors.black)),
          IconButton(
              onPressed: _handleClickAddCommentButton(context),
              icon:
                  const Icon(Icons.add_comment_outlined, color: Colors.black)),
          const Spacer(),
          IconButton(
              onPressed: _handleClickBookMarkButton,
              icon:
                  const Icon(Icons.bookmark_add_outlined, color: Colors.black)),
          const SizedBox(width: 15),
        ],
      );
}
