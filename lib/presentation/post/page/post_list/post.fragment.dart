import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/domain/entity/post/post.entity.dart';
import 'package:hot_place/presentation/post/bloc/get_post/get_post.bloc.dart';
import 'package:hot_place/presentation/post/bloc/get_post/get_post.event.dart';
import 'package:hot_place/presentation/post/bloc/get_post/get_post.state.dart';
import 'package:hot_place/presentation/post/page/post_list/post_list.widget.dart';

import '../../../../core/constant/response.constant.dart';
import '../../../../core/constant/route.constant.dart';

class PostFragment extends StatelessWidget {
  const PostFragment({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<GetPostBloc>()..add(InitPost()),
        child: BlocBuilder<GetPostBloc, GetPostState>(
          builder: (BuildContext _, state) {
            switch (state.status) {
              case Status.initial:
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.success:
                return PostView(state.stream!);
              case Status.error:
                return Center(
                    child: Text("ERROR",
                        style: Theme.of(context).textTheme.displayLarge));
            }
          },
        ),
      );
}

class PostView extends StatefulWidget {
  const PostView(this._stream, {super.key});

  final Stream<List<PostEntity>> _stream;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  _goToCreatePostPage() => context.push(Routes.createPost.path);

  // TODO : 검색 페이지로
  _goToSearchPostPage() {}

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("POST"),
        actions: [
          IconButton(
              onPressed: _goToCreatePostPage,
              icon: const Icon(Icons.add_box_outlined)),
          IconButton(
              onPressed: _goToSearchPostPage, icon: const Icon(Icons.search))
        ],
      ),
      body: PostListWidget(widget._stream));
}
