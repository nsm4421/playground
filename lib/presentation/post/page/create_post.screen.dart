import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/presentation/component/content_text_field.widget.dart';
import 'package:hot_place/presentation/component/hashtag_text_field.widget.dart';
import 'package:hot_place/presentation/post/bloc/upload_post/create_post.cubit.dart';

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
  late TextEditingController _tec;
  late List<String> _hashtags;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _hashtags = [];
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
  }

  _setHashtags(List<String> hashtags) => setState(() {
        _hashtags = hashtags;
      });

  // 포스팅 업로드
  _upload() => context.read<CreatePostCubit>()
    ..setContent(_tec.text)
    ..setHashtags(_hashtags)
    ..upload();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title:
              Text("포스팅 작성하기", style: Theme.of(context).textTheme.titleLarge),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _upload,
              icon: Icon(Icons.upload,
                  color: Theme.of(context).colorScheme.primary, size: 30),
              tooltip: "제출하기",
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 포스팅 본문
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ContentTextField(
                  label: "CONTENT",
                  tec: _tec,
                  placeholder: "포스팅 본문을 입력해주세요",
                ),
              ),
              const Divider(indent: 10, endIndent: 10, thickness: 1),

              // 해시태그
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: HashtagTextField(
                    label: "HASHTAG",
                    hashtags: _hashtags,
                    setHashtag: _setHashtags),
              )
            ],
          ),
        ),
      );
}
