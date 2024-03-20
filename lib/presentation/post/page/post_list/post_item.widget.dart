import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/post/bloc/get_post/get_post.bloc.dart';
import 'package:hot_place/presentation/post/bloc/get_post/get_post.event.dart';

import '../../../../domain/entity/post/post.entity.dart';
import '../../../component/hashtag_list.widget.dart';

class PostItemWidget extends StatefulWidget {
  const PostItemWidget(this._post, {super.key});

  final PostEntity _post;

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  bool _isLikeLoading = false;

  _handleLike() => setState(() {
        try {
          _isLikeLoading = true;
          if (widget._post.likeId == null) {
            // 좋아요 요청
            context.read<GetPostBloc>().add(LikePost(widget._post.id!));
          } else {
            // 좋아요 취소 요청
            context.read<GetPostBloc>().add(CancelLikePost(
                postId: widget._post.id!, likeId: widget._post.likeId!));
          }
        } catch (err) {
          debugPrint("좋아요 요청 실패");
        } finally {
          _isLikeLoading = false;
        }
      });

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 유저명
        Row(
          children: [
            CircleAvatar(
                child: widget._post.author?.photoUrl != null
                    ? Image.network(widget._post.author!.photoUrl!)
                    : const Icon(Icons.account_circle_outlined)),
            const SizedBox(width: 5),
            Text(
                widget._post.author?.username ??
                    widget._post.author?.email ??
                    "Unknown",
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700)),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(height: 20),

        // 이미지
        if (widget._post.images.isNotEmpty)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: PageView.builder(
                itemCount: widget._post.images.length,
                itemBuilder: (_, index) => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget._post.images[index]))))),
          ),

        // 본문
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
          child: Text(
            widget._post.content ?? "",
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),

        // 해시태그
        if (widget._post.hashtags.isNotEmpty)
          HashtagListWidget(widget._post.hashtags),

        // TODO : 댓글, 북마크 기능
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Row(
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                      onPressed: _isLikeLoading ? null : _handleLike,
                      icon: widget._post.likeId == null
                          ? const Icon(Icons.favorite_border)
                          : const Icon(Icons.favorite,
                              color: Colors.deepOrange),
                      tooltip: "좋아요"),
                  Text(widget._post.numLike.toString()),
                  const SizedBox(width: 10),
                ]),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mode_comment_outlined),
                      tooltip: "댓글"),
                  const Text("100"),
                  const SizedBox(width: 10),
                ]),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_add_outlined),
                    tooltip: "북마크")
              ],
            )),

        const SizedBox(height: 15),
        const Divider(indent: 10, endIndent: 10)
      ]);
}
