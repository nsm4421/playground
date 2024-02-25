import 'package:flutter/material.dart';
import 'package:hot_place/core/util/toast.util.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  static const int _maxHashtagNum = 5;

  late TextEditingController _contentTec;
  late TextEditingController _hashtagTec;
  List<String> _hashtags = [];

  @override
  void initState() {
    super.initState();
    _contentTec = TextEditingController();
    _hashtagTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _contentTec.dispose();
    _hashtagTec.dispose();
  }

  _clearContent() => _contentTec.clear();

  _addHashtag() {
    final text = _hashtagTec.text.trim();
    final isExist = _hashtags.contains(text);
    if (isExist) {
      ToastUtil.toast('이미 존재하는 해시태그 입니다');
      return;
    }
    setState(() {
      _hashtags.add(_hashtagTec.text);
      _hashtagTec.clear();
    });
  }

  _deleteHashtag(int index) => () => setState(() {
        _hashtags.removeAt(index);
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
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  children: [
                    Row(children: [
                      Text("CONTENT",
                          style: Theme.of(context).textTheme.titleLarge),
                      const Spacer(),
                      IconButton(
                          onPressed: _clearContent,
                          icon: const Icon(Icons.clear))
                    ]),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _contentTec,
                      maxLength: 1000,
                      minLines: 3,
                      maxLines: 10,
                      style:
                          const TextStyle(decorationThickness: 0, fontSize: 20),
                      decoration: const InputDecoration(
                          hintText: '본문을 1000자 내외로 입력해주세요',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(5)),
                    )
                  ],
                ),
              ),
              const Divider(indent: 10, endIndent: 10, thickness: 1),

              // 해시태그
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  children: [
                    Row(children: [
                      Text("HASHTAG",
                          style: Theme.of(context).textTheme.titleLarge)
                    ]),
                    const SizedBox(height: 10),

                    // 해시태그 입력창
                    TextField(
                      controller: _hashtagTec,
                      maxLength: 10,
                      minLines: 1,
                      maxLines: 1,
                      style:
                          const TextStyle(decorationThickness: 0, fontSize: 20),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.tag),
                          suffixIcon: _hashtags.length < _maxHashtagNum
                              ? IconButton(
                                  onPressed: _addHashtag,
                                  icon: Icon(
                                    Icons.add_box_outlined,
                                    size: 25,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ))
                              : null,
                          hintText: '해시태그를 입력해주세요',
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.all(5)),
                    ),
                    const SizedBox(height: 10),

                    // 해시태그 목록
                    Container(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                          children: List.generate(
                              _hashtags.length,
                              (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(Icons.tag,
                                              size: 25,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          const SizedBox(width: 5),
                                          Text(
                                            _hashtags[index],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          const SizedBox(width: 5),
                                          IconButton(
                                              onPressed: _deleteHashtag(index),
                                              icon: const Icon(
                                                  size: 25,
                                                  Icons.delete_outline))
                                        ],
                                      ),
                                    ),
                                  )).toList()),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
