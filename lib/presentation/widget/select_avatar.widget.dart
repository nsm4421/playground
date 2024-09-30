part of 'widgets.dart';

class SelectAvatarWidget extends StatefulWidget {
  const SelectAvatarWidget(this.initialImage, this.onSelect,
      {super.key, this.size = 200, this.iconSize = 50});

  final File? initialImage;
  final void Function(File? onSelect) onSelect;
  final double size;
  final double iconSize;

  @override
  State<SelectAvatarWidget> createState() => _SelectAvatarWidgetState();
}

class _SelectAvatarWidgetState extends State<SelectAvatarWidget> {
  late File? _image; // 미리보기를 위한 이미지
  late double? _radius;
  bool _isLoading = false; // 로딩중 여부

  @override
  initState() {
    super.initState();
    _image = widget.initialImage;
    _radius = widget.size / 2;
  }

  _handlePickImage() async {
    try {
      final selected = await customUtil.pickImageAndReturnCompressedImage(
          filename: 'select-image.jpg');
      if (selected != null) {
        widget.onSelect(selected);
        setState(() {
          _image = selected;
        });
      }
    } catch (error) {
      customUtil.logger.e(error);
    } finally {
      _isLoading = false;
    }
  }

  _handleUnSelectImage() {
    widget.onSelect(null);
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircleAvatar(
          radius: _radius,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          child: const Center(child: CircularProgressIndicator()));
    } else if (_image != null) {
      return Stack(children: [
        // 이미지 미리보기
        CircleAvatar(
            radius: _radius,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            backgroundImage: FileImage(_image!)),
        // 취소버튼
        Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Theme.of(context).colorScheme.error,
                size: widget.iconSize / 2,
              ),
              onPressed: _handleUnSelectImage,
            ))
      ]);
    } else {
      return InkWell(
          onTap: _handlePickImage,
          child: CircleAvatar(
            radius: _radius,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            child: Icon(
              Icons.add_a_photo_outlined,
              size: widget.iconSize,
            ),
          ));
    }
  }
}
