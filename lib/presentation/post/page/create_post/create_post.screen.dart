import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/presentation/post/page/create_post/detail.fragment.dart';

import '../../../../core/constant/status.costant.dart';
import '../../bloc/create_post/create_post.cubit.dart';
import '../../bloc/create_post/create_post.state.dart';
import 'image.fragment.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<CreatePostCubit>(),
        child: BlocListener<CreatePostCubit, CreatePostState>(
          listener: (context, state) {
            switch (state.status) {
              case Status.success:
                ToastUtil.toast('업로드 성공');
                context.pop();
              case Status.error:
                ToastUtil.toast('업로드 실패');
                return;
              default:
                return;
            }
          },
          child: BlocBuilder<CreatePostCubit, CreatePostState>(
            builder: (_, state) {
              switch (state.status) {
                case Status.initial:
                case Status.success:
                case Status.error:
                  return const _CreatePostView();
                case Status.loading:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
}

class _CreatePostView extends StatefulWidget {
  const _CreatePostView();

  @override
  State<_CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<_CreatePostView> {
  late PageController _pageController;

  @override
  initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _uploadPost() {
    if (context.read<CreatePostCubit>().tec.text.trim().isEmpty) {
      ToastUtil.toast("본문을 입력해주세요");
      return;
    }
    context.read<CreatePostCubit>().uploadPost();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title:
              Text("포스팅 작성하기", style: Theme.of(context).textTheme.titleLarge),
          centerTitle: true,
          actions: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: IconButton(
                onPressed: _uploadPost,
                icon: Icon(Icons.upload,
                    color: Theme.of(context).colorScheme.primary),
                tooltip: "업로드",
              ),
            )
          ],
        ),
        body: PageView.builder(
            controller: _pageController,
            pageSnapping: true,
            itemCount: 2,
            itemBuilder: (_, index) =>
                index == 0 ? const ImageFragment() : const DetailFragment()),
      );
}
