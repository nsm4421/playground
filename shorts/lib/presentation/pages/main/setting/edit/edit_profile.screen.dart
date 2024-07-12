part of 'edit_profile.page.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const int _maxLengthNickname = 20;
  static const int _maxLengthDescription = 300;

  late ImagePicker _imagePicker;
  late TextEditingController _nicknameTec;
  late TextEditingController _descriptionTec;
  late AccountEntity _account;
  bool _isImageChanged = false;
  XFile? _xFile;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _nicknameTec = TextEditingController();
    _descriptionTec = TextEditingController();
    _account = (context.read<UserBloc>().state as UserLoadedState).account;
    _nicknameTec.text = _account.nickname ?? '';
    _descriptionTec.text = _account.description ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameTec.dispose();
    _descriptionTec.dispose();
  }

  _handleSelectImage() async {
    try {
      _xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (_xFile != null) {
        _isImageChanged = true;
        setState(() {});
      }
    } catch (error) {
      log('이미지 선택 오류 ${error.toString()}');
    }
  }

  _handleCancelImage() {
    setState(() {
      _isImageChanged = true;
      _xFile = null;
    });
  }

  _handleSubmit() {
    // validate
    if (_nicknameTec.text.trim().isEmpty) {
      ToastUtil.toast('닉네임을 입력해주세요');
      return;
    } else if (_descriptionTec.text.trim().isEmpty) {
      ToastUtil.toast('자기소개를 입력해주세요');
      return;
    } else if (_xFile == null && _isImageChanged){
      ToastUtil.toast('이미지를 선택해주세요');
      return;
    }
    context.read<UserBloc>().add(EditProfileEvent(
        image: _xFile == null ? null : File(_xFile!.path),
        account: (context.read<UserBloc>().state as UserLoadedState)
            .account
            .copyWith(
                nickname: _nicknameTec.text.trim(),
                description: _descriptionTec.text.trim())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("프로필 수정"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 이미지
            Padding(
                padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
                child: _isImageChanged
                    ? (_xFile?.path == null
                        // 이미지 선택 버튼
                        ? GestureDetector(
                            onTap: _handleSelectImage,
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 3,
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                size: MediaQuery.of(context).size.width / 6,
                              ),
                            ),
                          )
                        // 이미지 미리보기
                        : Stack(
                            children: [
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                      onPressed: _handleCancelImage,
                                      icon: const Icon(Icons.clear, size: 35))),
                              CircleAvatar(
                                  radius: MediaQuery.of(context).size.width / 3,
                                  backgroundImage:
                                      FileImage(File(_xFile!.path))),
                            ],
                          ))
                    // 아직 이미지를 선택하지 않은 경우
                    : Stack(children: [
                        Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                                onPressed: _handleCancelImage,
                                icon: const Icon(Icons.clear, size: 35))),
                        AvatarWidget(_account.profileUrl!,
                            radius: MediaQuery.of(context).size.width / 3)
                      ])),

            // 닉네임
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
              child: TextFormField(
                maxLength: _maxLengthNickname,
                controller: _nicknameTec,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decorationThickness: 0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.account_circle_outlined),
                    helperText: '$_maxLengthNickname자 내외로 닉네임을 작명해주세요',
                    counterStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary)),
              ),
            ),

            // 자기소개
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
              child: TextFormField(
                maxLength: _maxLengthDescription,
                controller: _descriptionTec,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decorationThickness: 0, fontWeight: FontWeight.bold),
                minLines: 3,
                maxLines: 8,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    helperText: '$_maxLengthDescription자 내외로 자기소개를 해주세요',
                    counterStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary)),
              ),
            ),

            // 제출버튼
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
              child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SUBMIT",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
