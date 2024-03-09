import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/domain/usecase/post/get_post_stream.usecase.dart';

import '../../../core/constant/route.constant.dart';
import '../../component/hashtag_list.widget.dart';

class PostFragment extends StatefulWidget {
  const PostFragment({super.key});

  @override
  State<PostFragment> createState() => _PostFragmentState();
}

class _PostFragmentState extends State<PostFragment> {
  _goToCreatePostPage() => context.push(Routes.createPost.path);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("POST"),
        actions: [
          IconButton(
              onPressed: _goToCreatePostPage, icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<List<PostEntity>>(
          stream: getIt<GetPostStreamUseCase>().call(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                final data = snapshot.data;
                return data == null
                    ? Text("ERROR",
                        style: Theme.of(context).textTheme.displayLarge)
                    : _PostView(data);
              case ConnectionState.none:
              case ConnectionState.done:
                return Center(
                    child: Text("ERROR",
                        style: Theme.of(context).textTheme.displayLarge));
            }
          }));
}

class _PostView extends StatelessWidget {
  const _PostView(this._posts, {super.key});

  final List<PostEntity> _posts;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: _posts
              .map((post) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: _PostItem(post)))
              .toList(),
        ),
      );
}

class _PostItem extends StatelessWidget {
  const _PostItem(this._post, {super.key});

  final PostEntity _post;

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 유저명
        Row(
          children: [
            // TODO : 유저 프로필 이미지
            Text(_post.author?.username ?? _post.author?.email ?? "Unknown",
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
          PageView.builder(
              itemBuilder: (_, index) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(_post.images[index]))))),

        // 본문
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Text(
            _post.content ?? "",
            softWrap: true,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),

        // 해시태그
        if (_post.hashtags.isNotEmpty) HashtagListWidget(_post.hashtags),
        const SizedBox(height: 15),
        const Divider(indent: 10, endIndent: 10)
      ]);
}
