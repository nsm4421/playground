import 'package:flutter/material.dart';
import 'package:my_app/api/feed/feed.api.dart';
import 'package:my_app/configurations.dart';
import 'package:my_app/screen/component/comment_text_field.widget.dart';

import '../../../core/util/time_diff.util.dart';
import '../../../domain/model/feed/parent_feed_comment.model.dart';
import 'child_comment.widget.dart';

class ParentCommentWidget extends StatefulWidget {
  const ParentCommentWidget(this.fid, {super.key});

  final String fid;

  @override
  State<ParentCommentWidget> createState() => _ParentCommentWidgetState();
}

class _ParentCommentWidgetState extends State<ParentCommentWidget> {
  late ScrollController _sc;
  late Stream<List<ParentFeedCommentModel>> _stream;

  @override
  initState() {
    super.initState();
    _sc = ScrollController();
    _stream = getIt<FeedApi>().getParentCommentStream(widget.fid);
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

  _handleShowWriteCommentView() => showModalBottomSheet(
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
          child: CommentTextFieldWidget(fid: widget.fid),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<List<ParentFeedCommentModel>>(
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
                        comments: snapshot.data!, sc: _sc, fid: widget.fid)
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
              tooltip: 'Add Comment',
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
                child: Icon(Icons.add_comment,
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
      {required this.fid, required this.comments, required this.sc});

  final String fid;
  final List<ParentFeedCommentModel> comments;
  final ScrollController sc;

  _handleShowReplyView(
          {required BuildContext context,
          required ParentFeedCommentModel parentComment}) =>
      () {
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
            child: ChildCommentWidget(fid: fid, parentComment: parentComment),
          ),
        );
      };

  @override
  Widget build(BuildContext context) => ListView.separated(
        controller: sc,
        shrinkWrap: true,
        itemCount: comments.length,
        itemBuilder: (BuildContext context, int index) {
          final comment = comments[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0)
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Comments(${comments.length})",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.clear)),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ],
                ),
              ListTile(
                onTap: _handleShowReplyView(
                    context: context, parentComment: comment),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // nickname
                    Text(comment.nickname ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.primary)),
                    comment.createdAt != null
                        ? Text(
                            TimeDiffUtil.getTimeDiffRep(comment.createdAt!),
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
                subtitle: Text(comment.content ?? '', softWrap: true),
                titleTextStyle: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),

              // child comment count
              if ((comment.childCommentCount ?? 0) > 0)
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      "${comment.childCommentCount.toString()} replies",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ],
                ),

              // margin on bottom
              const SizedBox(height: 5)
            ],
          );
        },
        separatorBuilder: (_, __) => const Divider(indent: 20, endIndent: 20),
      );
}
