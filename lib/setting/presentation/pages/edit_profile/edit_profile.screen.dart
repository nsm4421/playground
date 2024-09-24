part of 'edit_profile.page.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late PresenceEntity _presence;
  late TextEditingController _tec;
  late FocusNode _focusNode;
  bool _isUsernameEditing = false;

  // bloc에서 emit을 발생시킬 수 있는 상태인지 여부
  // 먼저 실행된 이벤트가 처리되기 전에 다른 이벤트를 연달아 발생시켜서 에러 발생하는 걸 방지하기 위한 flag
  bool get _ok {
    final status = context.read<EditProfileCubit>().state.status;
    return (status == Status.initial) || (status == Status.success);
  }

  @override
  void initState() {
    super.initState();
    _presence = context.read<AuthenticationBloc>().presence;
    context.read<EditProfileCubit>().init(username: _presence.username);
    _tec = TextEditingController();
    _tec.text = _presence.username ?? '';
    _focusNode = FocusNode()..addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
    _focusNode
      ..removeListener(_focusNodeListener)
      ..dispose();
  }

  _focusNodeListener() {
    if (_ok) context.read<EditProfileCubit>().init(username: _tec.text.trim());
  }

  _handleUsername() async {
    if (!_ok) return;
    if (_isUsernameEditing) {
      await context.read<EditProfileCubit>().checkUsername().then((ok) {
        if (ok) {
          getIt<CustomSnakbar>().success(title: '사용 가능한 유저명입니다');
          setState(() {
            _isUsernameEditing = !_isUsernameEditing;
          });
        } else {
          getIt<CustomSnakbar>().error(title: '중복된 유저명입니다');
        }
      });
    } else {
      setState(() {
        _isUsernameEditing = !_isUsernameEditing;
      });
    }
  }

  _selectImage() async {
    if (!_ok) return;
    await context
        .read<EditProfileCubit>()
        .selectImage(filename: 'profile-image.jpg');
  }

  _unSelectImage() {
    if (!_ok) return;
    context.read<EditProfileCubit>().unSelectImage();
  }

  _submit() {
    if (!_ok) return;
    context.read<EditProfileCubit>()
      ..init(username: _tec.text.trim())
      ..submit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('프로필 수정하기')),
        body: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
          return SingleChildScrollView(
            child: Column(children: [
              // 프로필 이미지
              Padding(
                  padding: EdgeInsets.only(
                      top: CustomSpacing.lg, bottom: CustomSpacing.md),
                  child: GestureDetector(
                      onTap: _selectImage,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.7,
                          child: context
                                      .read<EditProfileCubit>()
                                      .state
                                      .profileImage ==
                                  null
                              ? CircularAvatarImageWidget(_presence.avatarUrl!)
                              : Stack(children: [
                                  CircleAvatar(
                                    radius: MediaQuery.of(context).size.width *
                                        0.35,
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainer,
                                    backgroundImage: FileImage(context
                                        .read<EditProfileCubit>()
                                        .state
                                        .profileImage!),
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.clear,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            size: CustomTextSize.xl,
                                          ),
                                          onPressed: _unSelectImage))
                                ])))),

              // 유저명
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: CustomSpacing.lg, horizontal: CustomSpacing.sm),
                  child: TextFormField(
                    focusNode: _focusNode,
                    readOnly: !_isUsernameEditing,
                    decoration: InputDecoration(
                        labelText: '유저명',
                        border: const OutlineInputBorder(),
                        suffixIcon: (state.status == Status.initial ||
                                state.status == Status.success)
                            ? IconButton(
                                onPressed: _handleUsername,
                                icon: _isUsernameEditing
                                    ? const Icon(Icons.check)
                                    : const Icon(Icons.edit))
                            : Transform.scale(
                                scale: 0.5,
                                child: const CircularProgressIndicator())),
                    controller: _tec,
                  )),

              ElevatedButton(onPressed: _submit, child: const Text("프로필 수정하기"))
            ]),
          );
        }));
  }
}
