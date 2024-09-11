part of 'create_feed.page.dart';

class AddHashtagFragment extends StatefulWidget {
  const AddHashtagFragment(this._currentHashtags, {super.key});

  final List<String> _currentHashtags;

  @override
  State<AddHashtagFragment> createState() => _AddHashtagFragmentState();
}

class _AddHashtagFragmentState extends State<AddHashtagFragment> {
  static const int _maxLength = 20;
  static const int _maxCount = 3;
  late TextEditingController _tec;
  late GlobalKey<FormState> _formKey;
  late List<String> _hashtags;

  @override
  initState() {
    super.initState();
    _tec = TextEditingController();
    _formKey = GlobalKey<FormState>(debugLabel: 'create-post-hashtag');
    _hashtags = widget._currentHashtags;
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  _addHashtag() {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    setState(() {
      _hashtags.add(_tec.text.trim());
    });
    _tec.clear();
  }

  String? _validateHashtag(String? text) {
    if (text == null || text.isEmpty) {
      return '해시태그를 입력해주세요';
    } else if (_hashtags.contains(text.trim())) {
      return '중복된 해시태그 입니다';
    } else if (_hashtags.length >= _maxCount) {
      return '최대 $_maxCount개까지 해시태그를 추가할 수 있습니다';
    }
    return null;
  }

  _removeHashtag(String text) => () {
        setState(() {
          _hashtags.remove(text);
        });
      };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // 화면이 닫힐 때 _hashtags 상태를 원래 화면으로 전달
      onWillPop: () async {
        context.pop(_hashtags);
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // 해시태그 입력창
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSpacing.sm, vertical: CustomSpacing.lg),
              child: Form(
                key: _formKey,
                child: TextFormField(
                    validator: _validateHashtag,
                    maxLines: 1,
                    maxLength: _maxLength,
                    controller: _tec,
                    decoration: InputDecoration(
                        label: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: CustomSpacing.tiny),
                          child: Icon(Icons.tag, size: CustomTextSize.xl),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: CustomSpacing.sm,
                          vertical: CustomSpacing.sm,
                        ),
                        helperText: '최대 $_maxCount개의 해시태그를 추가할 수 있어요',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: _addHashtag,
                            icon: const Icon(Icons.add)))),
              ),
            ),

            // 해시태그 목록
            Padding(
              padding: EdgeInsets.only(
                  left: CustomSpacing.sm,
                  right: CustomSpacing.sm,
                  top: CustomSpacing.sm,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: _hashtags
                    .map((text) => Container(
                          margin: EdgeInsets.only(
                              right: CustomSpacing.sm, top: CustomSpacing.tiny),
                          padding: EdgeInsets.symmetric(
                              horizontal: CustomSpacing.sm,
                              vertical: CustomSpacing.tiny),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(CustomSpacing.sm),
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.tag,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              CustomWidth.tiny,
                              Text(
                                text,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                              CustomWidth.sm,
                              GestureDetector(
                                  onTap: _removeHashtag(text),
                                  child: Icon(Icons.clear,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary))
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
