import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/presentation/pages/feed/feed_comment/write_feed_comment.widget.dart';

class FeedCommentViewWidget extends StatefulWidget {
  const FeedCommentViewWidget(this.feedId, {super.key});

  final String feedId;

  @override
  State<FeedCommentViewWidget> createState() => _FeedCommentViewWidgetState();
}

class _FeedCommentViewWidgetState extends State<FeedCommentViewWidget> {
  /// 댓글 입력창 화면 띄우기
  _handleShowTextField() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: min(
            MediaQuery.of(context).size.height * 0.8,
            MediaQuery.of(context).size.height / 3 +
                MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: EdgeInsets.only(
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: WriteFeedCommentWidget(widget.feedId),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      barrierColor: Colors.grey.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          const Spacer(),
          // 댓글쓰기 버튼
          InkWell(
            onTap: _handleShowTextField,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary,
              ),
              width: MediaQuery.of(context).size.width,
              child: Text(
                textAlign: TextAlign.center,
                "댓글쓰기",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ),
          const SizedBox(height: 10)
        ],
      );
}
