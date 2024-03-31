import 'package:flutter/material.dart';
import 'package:hot_place/core/util/toast.util.dart';

class HashtagFragment extends StatefulWidget {
  const HashtagFragment({
    super.key,
    required List<String> hashtags,
    required void Function(List<String>) handleSetHashtags,
  })  : _hashtags = hashtags,
        _handleSetHashtags = handleSetHashtags;

  final List<String> _hashtags;
  final void Function(List<String>) _handleSetHashtags;

  @override
  State<HashtagFragment> createState() => _HashtagFragmentState();
}

class _HashtagFragmentState extends State<HashtagFragment> {
  late TextEditingController _textEditingController;

  static const int _maxHashtag = 5;
  static const int _maxLength = 20;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  _handleAddNewHashtag() {
    final newHashtag = _textEditingController.text.trim();
    if (newHashtag.isEmpty) {
      ToastUtil.toast('해시태그를 입력해주세요');
      return;
    } else if (widget._hashtags.length >= _maxHashtag) {
      ToastUtil.toast('해시태그는 최대 $_maxHashtag개까지 가능합니다');
      return;
    } else if (widget._hashtags.contains(newHashtag)) {
      ToastUtil.toast('$newHashtag는 중복된 해시태그 입니다');
      return;
    } else {
      widget._handleSetHashtags([...widget._hashtags, newHashtag]);
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 헤더
          Row(
            children: [
              const Icon(Icons.tag),
              const SizedBox(width: 5),
              Text("HASHTAG",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 10),

          // 해시태그 입력창
          TextField(
            controller: _textEditingController,
            maxLines: 1,
            maxLength: _maxLength,
            decoration: InputDecoration(
                hintText: "해시태그",
                prefixIcon: const Icon(Icons.abc),
                suffixIcon: widget._hashtags.length < _maxHashtag
                    ? IconButton(
                        onPressed: _handleAddNewHashtag,
                        icon: const Icon(Icons.add_circle_outline),
                      )
                    : null),
          ),
          const SizedBox(height: 10),

          // 해시태그 목록
          Container(
              alignment: Alignment.topLeft,
              child: Wrap(
                  children: widget._hashtags
                      .map((text) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
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
                                    Text(text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w800))
                                  ]))))
                      .toList()))
        ],
      );
}
