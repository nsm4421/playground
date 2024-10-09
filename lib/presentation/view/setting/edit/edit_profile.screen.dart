part of 'index.page.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late PresenceEntity _presence;
  late TextEditingController _usernameTec;
  static const _minUsernameLength = 3;
  static const _maxUsernameLength = 15;
  bool _readOnly = true;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _usernameTec = TextEditingController();
    _presence = context.read<AuthenticationBloc>().state.currentUser!;
    _usernameTec.text = _presence.username;
  }

  @override
  dispose() {
    super.dispose();
    _usernameTec.dispose();
  }

  _handlePop() {
    if (context.canPop()) {
      context.pop();
    }
  }

  _handleUnSelectImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  _handleClear() {
    _usernameTec.clear();
  }

  _handleReadOnly(bool readOnly) => () {
        setState(() {
          _readOnly = readOnly;
        });
      };

  _handleSelectProfileImage() async {
    await customUtil.pickImageAndReturnCompressedImage().then((res) {
      if (res == null) return;
      setState(() {
        _selectedImage = res;
      });
    });
  }

  _handleSubmit() async {
    final text = _usernameTec.text.trim();
    final newUsername = _presence.username == text ? null : text;
    if (newUsername == null && _selectedImage == null) {
      // 변경사항이 없는 경우
      customUtil.showWarningSnackBar(
          context: context, message: 'nothing to update');
      return;
    } else if (text.length < _minUsernameLength) {
      // 유저명이 너무 짧은 경우
      customUtil.showWarningSnackBar(
          context: context,
          message: 'minimum length is username is $_minUsernameLength');
      return;
    } else if (text.length > _maxUsernameLength) {
      // 유저명이 너무 긴 경우
      customUtil.showWarningSnackBar(
          context: context,
          message: 'maximum length is username is $_maxUsernameLength');
      return;
    } else {
      // 프로필 업데이트 요청
      context.read<AuthenticationBloc>().add(EditProfileEvent(
          newProfileImage: _selectedImage, newUsername: newUsername));
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _handlePop,
        ),
        title: const Text('Edit Profile'),
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
        /// 프로필 사진 선택
        Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 30),
            child: Stack(children: [
              // 이미지
              GestureDetector(
                onTap: _handleSelectProfileImage,
                child: _selectedImage == null
                    ? CircularAvatarWidget(_presence.avatarUrl, size: imageSize)
                    : CircularAvatarAssetWidget(_selectedImage!,
                        size: imageSize),
              ),
              // 취소 버튼
              if (_selectedImage != null)
                Positioned(
                    top: -15,
                    right: -15,
                    child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _handleUnSelectImage))
            ])),

        /// 유저 정보
        Column(children: [
          // 유저명
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: CustomTextFieldWidget(_usernameTec,
                  readOnly: _readOnly,
                  onTap: _handleReadOnly(false),
                  onFocusLeave: _handleReadOnly(true),
                  helperText:
                      'use $_minUsernameLength~$_maxUsernameLength characters',
                  maxLength: _maxUsernameLength,
                  prefixIcon: Icons.account_box_outlined,
                  suffixIcon: Icons.clear,
                  onTapSuffixIcon: _handleClear)),

          const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Divider())
        ])
      ]))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: _handleSubmit,
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle),
              child: Icon(Icons.check,
                  size: 35, color: Theme.of(context).colorScheme.primary))),
    );
  }
}
