import 'package:flutter/material.dart';

import '../../core/util/toast.util.dart';

class HashtagTextField extends StatefulWidget {
  const HashtagTextField(
      {super.key,
      String? label,
      int maxHashtagNum = 5,
      required List<String> hashtags,
      required void Function(List<String>) setHashtag})
      : _maxHashtagNum = maxHashtagNum,
        _hashtags = hashtags,
        _setHashtag = setHashtag,
        _label = label;

  final String? _label;
  final int _maxHashtagNum;
  final List<String> _hashtags;
  final void Function(List<String> hashtags) _setHashtag;

  @override
  State<HashtagTextField> createState() => _HashtagTextFieldState();
}

class _HashtagTextFieldState extends State<HashtagTextField> {
  late TextEditingController _tec;

  @override
  initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
  }

  _addHashtag() {
    final text = _tec.text.trim();
    if (text.isEmpty) {
      return;
    }
    final isExist = widget._hashtags.contains(text);
    if (isExist) {
      ToastUtil.toast('이미 존재하는 해시태그 입니다');
      return;
    }
    widget._setHashtag([...widget._hashtags, text]);
    _tec.clear();
  }

  _deleteHashtag(int index) => () {
        final temp = [...widget._hashtags];
        temp.removeAt(index);
        widget._setHashtag(temp);
      };

  @override
  Widget build(BuildContext context) => Column(children: [
        /// label
        if (widget._label != null)
          Column(
            children: [
              Row(children: [
                Text(widget._label!,
                    style: Theme.of(context).textTheme.titleLarge),
                Spacer(),
                Text(
                  "(${widget._hashtags.length}/${widget._maxHashtagNum})",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                )
              ]),
              const SizedBox(height: 10),
            ],
          ),

        /// 해시태그 입력
        TextField(
          controller: _tec,
          maxLength: 10,
          minLines: 1,
          maxLines: 1,
          style: const TextStyle(decorationThickness: 0, fontSize: 20),
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.tag),
              suffixIcon: widget._hashtags.length < widget._maxHashtagNum
                  ? IconButton(
                      onPressed: _addHashtag,
                      icon: Icon(
                        Icons.add_box_outlined,
                        size: 25,
                        color: Theme.of(context).colorScheme.primary,
                      ))
                  : null,
              hintText: '해시태그를 입력해주세요',
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(5)),
        ),
        const SizedBox(height: 10),

        /// 해시태그 목록
        Container(
            alignment: Alignment.topLeft,
            child: Wrap(
                children: List.generate(
                    widget._hashtags.length,
                    (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
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
                                    widget._hashtags[index],
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
                                      icon: const Icon(size: 20, Icons.clear))
                                ])))).toList()))
      ]);
}
