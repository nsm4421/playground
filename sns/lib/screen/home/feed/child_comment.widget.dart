import 'package:flutter/material.dart';
import 'package:my_app/domain/model/feed/child_feed_comment.model.dart';
import 'package:my_app/screen/component/comment_text_field.widget.dart';

import '../../../api/feed/feed.api.dart';
import '../../../configurations.dart';
import '../../../core/util/time_diff.util.dart';
import '../../../domain/model/feed/parent_feed_comment.model.dart';

class ChildCommentWidget extends StatefulWidget {
  const ChildCommentWidget(
      {super.key, required this.fid, required this.parentComment});

  final String fid;
  final ParentFeedCommentModel parentComment;

  @override
  State<ChildCommentWidget> createState() => _ChildCommentWidgetState();
}

class _ChildCommentWidgetState extends State<ChildCommentWidget> {
  late ScrollController _sc;
  late Stream<List<ChildFeedCommentModel>> _stream;

  @override
  initState() {
    super.initState();
    _sc = ScrollController();
    _stream = getIt<FeedApi>().getChildCommentStream(
        fid: widget.fid, parentCid: widget.parentComment.cid!);
  }

  @override
  dispose() {
    super.dispose();
    _sc.dispose();
  }

  _handleJumpToTop() {
    if (_sc.hasClients) {
      _sc.animateTo(0,
          duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    }
  }

  _handleShowWriteCommentView() {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      enableDrag: true,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
        child: CommentTextFieldWidget(
            fid: widget.fid, parentCid: widget.parentComment.cid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<List<ChildFeedCommentModel>>(
          stream: _stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                return (!snapshot.hasError && snapshot.hasData)
                    ? _CommentList(
                        comments: snapshot.data!,
                        sc: _sc,
                        fid: widget.fid,
                        parentComment: widget.parentComment)
                    : const Center(child: Text("Error"));
            }
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              tooltip: 'Jump To Top',
              onPressed: _handleJumpToTop,
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.8),
                ),
                child: Icon(Icons.arrow_upward_outlined,
                    size: 30, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            IconButton(
              tooltip: 'Add Reply',
              onPressed: _handleShowWriteCommentView,
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.8),
                ),
                child: Icon(Icons.reply,
                    size: 30, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
}

class _CommentList extends StatelessWidget {
  const _CommentList(
      {required this.fid,
      required this.comments,
      required this.sc,
      required this.parentComment});

  final String fid;
  final List<ChildFeedCommentModel> comments;
  final ScrollController sc;
  final ParentFeedCommentModel parentComment;

  _handleClose(BuildContext context) => () => Navigator.pop(context);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        controller: sc,
        child: Column(
          children: [
            Column(
              children: [
                // header
                Row(
                  children: [
                    Text(
                      "Replies (${comments.length})",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: _handleClose(context),
                        icon: const Icon(Icons.clear)),
                    const SizedBox(height: 30),
                  ],
                ),
              ],
            ),
            Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // nickname
                    Text(parentComment.nickname ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.primary)),
                    parentComment.createdAt != null
                        ? Text(
                            TimeDiffUtil.getTimeDiffRep(
                                parentComment.createdAt!),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                          )
                        : const SizedBox()
                  ],
                ),
                subtitle: Text(parentComment.content ?? '', softWrap: true),
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (BuildContext context, int index) {
                final comment = comments[index];
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // nickname
                          Text(comment.nickname ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                          comment.createdAt != null
                              ? Text(
                                  TimeDiffUtil.getTimeDiffRep(
                                      comment.createdAt!),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary),
                                )
                              : const SizedBox()
                        ],
                      ),
                      subtitle: Text(comment.content ?? '', softWrap: true),
                      titleTextStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.tertiary),
                    ),

                    // margin on bottom
                    const SizedBox(height: 5)
                  ],
                );
              },
              separatorBuilder: (_, __) =>
                  const Divider(indent: 20, endIndent: 20),
            ),
          ],
        ),
      );
}
