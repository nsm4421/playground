import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/data/data_source/remote/feed/feed.api.dart';
import 'package:my_app/dependency_injection.dart';
import 'package:my_app/domain/model/feed/feed_comment.model.dart';
import 'package:my_app/presentation/pages/feed/bloc/feed_comment.bloc.dart';
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

  _handleCancel() => context.pop();

  // TODO : 무한스크롤링 기능 구현하기
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.cancel_outlined),
              onPressed: _handleCancel),
          centerTitle: true,
          title: Text("Comments", style: GoogleFonts.lobster(fontSize: 20)),
        ),
        body: StreamBuilder<List<FeedCommentModel>>(
          stream: getIt<FeedApi>().getFeedCommentStream(widget.feedId),
          initialData: context.read<FeedCommentBloc>().state.comments,
          builder: (_, AsyncSnapshot<List<FeedCommentModel>> snapshot) {
            // 로딩중
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // 데이터 가져오기 실패
            if (snapshot.data == null) return const Text("NO DATA");

            return ListView.separated(
              itemBuilder: (_, index) =>
                  _CommentItemWidget(snapshot.data![index]),
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              separatorBuilder: (_, __) => const Divider(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: _handleShowTextField,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary,
              ),
              width: MediaQuery.of(context).size.width,
              child: const Icon(Icons.add_comment_outlined),
            )),
      );
}

class _CommentItemWidget extends StatelessWidget {
  const _CommentItemWidget(this.comment, {super.key});

  final FeedCommentModel comment;

  static const double _marginSize = 15;

  String _formatDate(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff < const Duration(minutes: 1)) {
      return "방금 전";
    } else if (diff < const Duration(hours: 1)) {
      return "${diff.inMinutes}분 전";
    } else if (diff < const Duration(days: 1)) {
      return "${diff.inHours}시간 전";
    } else if (diff < const Duration(days: 30)) {
      return "${diff.inDays}일전";
    } else {
      return "${dt.year}년 ${dt.month}월 ${dt.day}일";
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(_marginSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO : 실제 유저 프로필 사진
            const CircleAvatar(),
            const SizedBox(width: _marginSize),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // TODO : 실제 유저 닉네임
                    const Text('nickname',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(width: _marginSize),
                    if (comment.createdAt != null)
                      Text(_formatDate(comment.createdAt!),
                          style: const TextStyle(color: Colors.grey))
                  ],
                ),
                const SizedBox(height: _marginSize),
                Text(comment.content ?? '',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            )
          ],
        ),
      );
}
