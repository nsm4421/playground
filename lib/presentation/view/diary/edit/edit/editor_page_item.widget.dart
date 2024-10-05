part of '../index.page.dart';

class EditorPageItemWidget extends StatefulWidget {
  const EditorPageItemWidget(this._page, {super.key});

  final DiaryPage _page;

  @override
  State<EditorPageItemWidget> createState() => _EditorPageItemWidgetState();
}

class _EditorPageItemWidgetState extends State<EditorPageItemWidget> {
  static const _maxLength = 1000;
  late TextEditingController _tec;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController()..text = widget._page.caption;
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  // 텍스트 필드 모달을 보여줌
  _handleShowModal() async {
    await showModalBottomSheet<String?>(
            context: context,
            showDragHandle: true,
            enableDrag: true,
            builder: (context) => EditTextWidget(initialText: _tec.text))
        .then((res) {
      if (res == null || res.isEmpty) return;
      _tec.text = res;
      context
          .read<EditDiaryBloc>()
          .add(UpdateCaptionEvent(index: widget._page.index, caption: res));
    });
  }

  _handleUnSelectImage() {
    context
        .read<EditDiaryBloc>()
        .add(UpdateImageEvent(index: widget._page.index, image: null));
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        if (widget._page.image != null)
          Stack(
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(widget._page.image!))),
              ),
              // 그라디언트
              Positioned(
                  right: 0,
                  top: 0,
                  child:
                      // 그라디언트 효과
                      Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  Colors.transparent
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.centerLeft,
                              )))),

              // 취소버튼
              Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                      onPressed: _handleUnSelectImage,
                      icon: const Icon(Icons.clear,
                          size: 30, color: Colors.white)))
            ],
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: TextField(
              onTap: _handleShowModal,
              readOnly: true,
              minLines: 3,
              maxLines: 10,
              controller: _tec,
              decoration: const InputDecoration(
                  hintText: '캡션을 입력해주세요', counterText: ''),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  letterSpacing: 1.5,
                  decorationThickness: 0,
                  fontWeight: FontWeight.w700),
              maxLength: _maxLength),
        )
      ]),
    ));
  }
}
