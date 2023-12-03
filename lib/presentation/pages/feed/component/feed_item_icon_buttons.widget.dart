import 'package:flutter/material.dart';

class FeedItemIconButtonsWidget extends StatelessWidget {
  const FeedItemIconButtonsWidget({super.key});

  // TODO : 이벤트 등록 - 좋아요, 댓글, 북마크
  _handleClickFavoriteButton() {}

  _handleClickAddCommentButton() {}

  _handleClickBookMarkButton() {}

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 15),
          IconButton(
              onPressed: _handleClickFavoriteButton,
              icon: const Icon(Icons.favorite_outline, color: Colors.black)),
          IconButton(
              onPressed: _handleClickAddCommentButton,
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
