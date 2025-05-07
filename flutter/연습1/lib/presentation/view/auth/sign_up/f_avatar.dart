part of 'index.dart';

class SelectAvatarWidget extends StatefulWidget {
  const SelectAvatarWidget({super.key});

  @override
  State<SelectAvatarWidget> createState() => _SelectAvatarWidgetState();
}

class _SelectAvatarWidgetState extends State<SelectAvatarWidget> {
  static const _imageFileName = 'select-profile-image.jpg';
  static const double _selectedBoxSize = 200;
  static const double _unSelectedBoxSize = 100;
  late ImagePicker _imagePicker;
  File? _image;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  _handlePickImage() async {
    setState(() {
      _isLoading = true;
    });
    await CustomImageUtil.pickImageAndReturnCompressedImage(
            filename: _imageFileName, imagePicker: _imagePicker)
        .then((selected) {
      if (selected == null) return;
      _image = selected;
      context.read<SignUpCubit>().selectProfileImage(selected);
    }).catchError((error) {
      context.read<SignUpCubit>().init(
          status: Status.error,
          message: 'error occurs on selecting profile image');
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  _handleUnSelectImage() {
    context.read<SignUpCubit>().unSelectProfileImage();
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: _isLoading ? null : _handlePickImage,
          child: AnimatedContainer(
            duration: 1.sec,
            width: (_image == null) ? _unSelectedBoxSize : _selectedBoxSize,
            height: (_image == null) ? _unSelectedBoxSize : _selectedBoxSize,
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: _image == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover, image: FileImage(_image!))),
            child: _image == null
                ? CircleAvatar(
                    radius: _unSelectedBoxSize / 2,
                    backgroundColor:
                        context.colorScheme.tertiaryContainer.withOpacity(0.8),
                    child: Icon(
                      Icons.add_a_photo_outlined,
                      size: _unSelectedBoxSize / 4,
                      color: context.colorScheme.onTertiary,
                    ),
                  )
                : null,
          ),
        ),

        // 취소버튼
        if (_image != null)
          Positioned(
            top: -_selectedBoxSize / 15,
            right: -_selectedBoxSize / 15,
            child: IconButton(
              icon: Icon(Icons.clear, color: context.colorScheme.secondary),
              onPressed: _handleUnSelectImage,
            ),
          )
      ],
    );
  }
}
