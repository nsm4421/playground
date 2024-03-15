import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/domain/usecase/post/get_post_stream.usecase.dart';
import 'package:hot_place/presentation/post/widget/post_item.widget.dart';

import '../../../core/constant/route.constant.dart';

class PostFragment extends StatefulWidget {
  const PostFragment({super.key});

  @override
  State<PostFragment> createState() => _PostFragmentState();
}

class _PostFragmentState extends State<PostFragment> {
  _goToCreatePostPage() => context.push(Routes.createPost.path);

  // TODO : 검색 페이지로
  _goToSearchPostPage() {}

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("POST"),
        actions: [
          IconButton(
              onPressed: _goToSearchPostPage, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: _goToCreatePostPage, icon: const Icon(Icons.create))
        ],
      ),
      body: StreamBuilder<List<PostEntity>>(
          // TODO : 추후 수정
          //   stream: getIt<GetPostStreamUseCase>()(),
          stream: null,
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
  const _PostView(this._posts);

  final List<PostEntity> _posts;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: _posts
              .map((post) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: PostItemWidget(post)))
              .toList(),
        ),
      );
}
