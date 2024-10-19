part of 'page.dart';

class EditAssetWidget extends StatefulWidget {
  const EditAssetWidget(this._initialAsset, {super.key});

  final DiaryAsset _initialAsset;

  @override
  State<EditAssetWidget> createState() => _EditAssetWidgetState();
}

class _EditAssetWidgetState extends State<EditAssetWidget> {
  late DiaryAsset _asset;
  late TextEditingController _captionTec;

  @override
  void initState() {
    super.initState();
    _asset = widget._initialAsset;
    _captionTec = TextEditingController()..addListener(_handleUpdateCaption);
    _captionTec.text = widget._initialAsset.caption;
  }

  @override
  void dispose() {
    super.dispose();
    _captionTec
      ..removeListener(_handleUpdateCaption)
      ..dispose();
  }

  _handleUpdateImage() async {
    await customUtil.pickImageAndReturnCompressedImage().then((res) {
      if (res != null) {
        setState(() {
          _asset = _asset.copyWith(image: res);
        });
      }
    });
  }

  _handleUpdateCaption() {
    _asset = _asset.copyWith(caption: _captionTec.text);
  }

  _handleClear() {
    _captionTec.clear();
  }

  Future<bool> _handleOnWillPop() async {
    context.pop<DiaryAsset?>(_asset);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleOnWillPop,
      child: Scaffold(
          body: SingleChildScrollView(
              child: Column(children: [
            GestureDetector(
                onTap: _handleUpdateImage,
                child: Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: FileImage(_asset.image))),
                  )
                ])),

            // 본문
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: CustomTextFieldWidget(_captionTec,
                    suffixIcon: Icons.clear,
                    onTapSuffixIcon: _handleClear,
                    minLine: 1,
                    maxLine: 5,
                    maxLength: 200,
                    hintText: 'caption'))
          ])),
          floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                /// 작성완료
                RoundIconButtonWidget(
                    iconData: Icons.check,
                    voidCallback: () async {
                      context.pop<DiaryAsset?>(_asset);
                    }),

                /// 삭제 아이콘
                RoundIconButtonWidget(
                    iconData: Icons.delete_forever,
                    voidCallback: () async {
                      context.pop<DiaryAsset?>(null);
                    })
              ]))),
    );
  }
}
