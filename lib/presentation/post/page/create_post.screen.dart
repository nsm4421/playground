import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/presentation/post/bloc/upload_post/create_post.cubit.dart';
import 'package:hot_place/presentation/post/page/detail.fragment.dart';
import 'package:hot_place/presentation/post/page/image.fragment.dart';

import '../../../core/constant/status.costant.dart';
import '../bloc/upload_post/create_post.state.dart';

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
  const _CreatePostView({super.key});

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

  // TODO : 이미지 업로드 기능 추가
  _upload() {
    try {
      context.read<CreatePostCubit>().upload();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title:
                Text("포스팅 작성하기", style: Theme.of(context).textTheme.titleLarge),
            centerTitle: true),
        body: PageView.builder(
            itemBuilder: (_, index) =>
                index == 0 ? const ImageFragment() : const DetailFragment()),
      );
}
