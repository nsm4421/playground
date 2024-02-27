import 'package:flutter/material.dart';
import 'package:hot_place/presentation/component/content_text_field.widget.dart';
import 'package:hot_place/presentation/component/hashtag_text_field.widget.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late TextEditingController _contentTec;

  List<String> _hashtags = [];

  @override
  void initState() {
    super.initState();
    _contentTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _contentTec.dispose();
  }

  _setHashtags(List<String> newHashtag) => setState(() {
        _hashtags = newHashtag;
      });

  // TODO : 포스팅 제출
  _submitPost() {}

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title:
              Text("포스팅 작성하기", style: Theme.of(context).textTheme.titleLarge),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _submitPost,
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
                  tec: _contentTec,
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
