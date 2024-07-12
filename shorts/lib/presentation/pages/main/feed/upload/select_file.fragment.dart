part of 'upload_feed.page.dart';

class SelectFileFragment extends StatefulWidget {
  const SelectFileFragment({super.key});

  @override
  State<SelectFileFragment> createState() => _SelectFileFragmentState();
}

class _SelectFileFragmentState extends State<SelectFileFragment> {
  late ImagePicker _imagePicker;

  File? get _file => context.read<UploadFeedCubit>().state.file;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _handlePickMedia() async {
    await _imagePicker.pickImage(source: ImageSource.gallery).then((res) {
      if (res?.path != null) {
        final temp = File(res!.path);
        context.read<UploadFeedCubit>().setFile(temp);
        setState(() {});
      }
    });
  }

  _handleCancel() {
    context.read<UploadFeedCubit>().setFile(null);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: _file == null
                    // 이미지, 동영상 선택 버튼
                    ? GestureDetector(
                        onTap: _handlePickMedia,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: MediaQuery.of(context).size.width / 4,
                              ),
                              const SizedBox(height: 20),
                              const Text("이미지나 동영상을 선택해주세요")
                            ],
                          ),
                        ),
                      )
                    // 미리보기
                    : MediaPreviewWidget(_file!)),
          ),
          if (_file != null)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _handleCancel,
              ),
            )
        ],
      ),
    );
  }
}
