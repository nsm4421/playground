import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';
import 'package:my_app/dependency_injection.dart';
import 'package:my_app/domain/repository/feed.repository.dart';

class WriteFeedCommentWidget extends StatefulWidget {
  const WriteFeedCommentWidget(this.feedId, {super.key});

  final String feedId;

  @override
  State<WriteFeedCommentWidget> createState() => _WriteFeedCommentWidgetState();
}

class _WriteFeedCommentWidgetState extends State<WriteFeedCommentWidget> {
  late TextEditingController _tec;
  bool _isLoading = false;

  @override
  initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handleSubmitComment() async {
    if (_tec.text.isEmpty || widget.feedId.isEmpty) return;
    setState(() {
      _isLoading = true;
    });
    try {
      await getIt<FeedRepository>()
          .saveFeedComment(content: _tec.text.trim(), feedId: widget.feedId);
      if (context.mounted) {
        context.pop();
      }
    } catch (err) {
      CustomLogger.logger.e(err);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.only(top: 30, right: 8, left: 8),
                child: Stack(
                  children: [
                    TextFormField(
                      controller: _tec,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: '댓글을 입력해주세요',
                        hintStyle:
                            TextStyle(color: Color(0xff606060), fontSize: 12),
                        contentPadding: EdgeInsets.only(right: 90),
                      ),
                    ),
                    // 제출 버튼
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                            icon: Icon(Icons.send,
                                color: Theme.of(context).colorScheme.primary),
                            onPressed: _handleSubmitComment))
                  ],
                ),
              ),
      );
}
