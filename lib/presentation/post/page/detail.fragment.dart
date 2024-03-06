import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/content_text_field.widget.dart';
import '../../component/hashtag_text_field.widget.dart';
import '../bloc/upload_post/create_post.cubit.dart';

class DetailFragment extends StatefulWidget {
  const DetailFragment({super.key});

  @override
  State<DetailFragment> createState() => _DetailFragmentState();
}

class _DetailFragmentState extends State<DetailFragment> {

  _setHashtags(List<String> hashtags) => setState(() {
        context.read<CreatePostCubit>().setHashtags(hashtags);
      });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            // 포스팅 본문
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ContentTextField(
                label: "CONTENT",
                tec: context.read<CreatePostCubit>().tec,
                placeholder: "포스팅 본문을 입력해주세요",
              ),
            ),
            const Divider(indent: 10, endIndent: 10, thickness: 1),

            // 해시태그
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: HashtagTextField(
                  label: "HASHTAG",
                  hashtags: context.read<CreatePostCubit>().state.hashtags,
                  setHashtag: _setHashtags),
            )
          ],
        ),
      );
}
