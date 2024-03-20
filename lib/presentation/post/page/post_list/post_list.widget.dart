import 'package:flutter/material.dart';

import '../../../../domain/entity/post/post.entity.dart';
import 'post_item.widget.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget(this._stream, {super.key});

  final Stream<List<PostEntity>> _stream;

  @override
  Widget build(BuildContext context) => StreamBuilder<List<PostEntity>>(
      stream: _stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const _OnLoading();
          case ConnectionState.active:
            final data = snapshot.data;
            return data == null ? const _OnError() : _OnSuccess(data);
          case ConnectionState.none:
          case ConnectionState.done:
            return const _OnError();
        }
      });
}

class _OnSuccess extends StatelessWidget {
  const _OnSuccess(this._posts, {super.key});

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

class _OnLoading extends StatelessWidget {
  const _OnLoading({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

class _OnError extends StatelessWidget {
  const _OnError({super.key});

  @override
  Widget build(BuildContext context) => Center(
      child: Text("ERROR", style: Theme.of(context).textTheme.displayLarge));
}
