import 'package:flutter/material.dart';

import '../../../domain/entity/post/post.entity.dart';
import '../../component/hashtag_list.widget.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget(this._post, {super.key});

  final PostEntity _post;

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 유저명
        Row(
          children: [
            CircleAvatar(
                child: _post.author?.photoUrl != null
                    ? Image.network(_post.author!.photoUrl!)
                    : const Icon(Icons.account_circle_outlined)),
            const SizedBox(width: 5),
            Text(_post.author?.username ?? _post.author?.email ?? "Unknown",
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
        if (_post.images.isNotEmpty)
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: PageView.builder(
                itemCount: _post.images.length,
                itemBuilder: (_, index) => Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(_post.images[index]))))),
          ),

        // 본문
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
          child: Text(
            _post.content ?? "",
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),

        // 해시태그
        if (_post.hashtags.isNotEmpty) HashtagListWidget(_post.hashtags),

        // TODO : 좋아요, 댓글, 북마크 기능
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Row(
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      tooltip: "좋아요"),
                  // TODO : 좋아요 개수
                  Text("100"),
                  SizedBox(width: 10),
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
