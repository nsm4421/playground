part of 'sign_up.page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const _maxEmailLength = 30;
  static const _maxPasswordLength = 30;
  static const _minUsernameLength = 3;
  static const _maxUsernameLength = 15;

  late ImagePicker _imagePicker;
  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;
  late TextEditingController _passwordConfirmTec;
  late TextEditingController _usernameTec;
  late GlobalKey<FormState> _formKey;

  bool _isPasswordVisibile = false;
  bool _isPasswordConfirmVisibile = false;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _passwordConfirmTec = TextEditingController();
    _usernameTec = TextEditingController();
    _formKey = GlobalKey<FormState>(debugLabel: 'sign-up');
  }

  @override
  dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
    _passwordConfirmTec.dispose();
    _usernameTec.dispose();
  }

  _switchPasswordVisibility() {
    setState(() {
      _isPasswordVisibile = !_isPasswordVisibile;
    });
  }

  _switchPasswordConfirmVisibility() {
    setState(() {
      _isPasswordConfirmVisibile = !_isPasswordConfirmVisibile;
    });
  }

  String? _validateEmail(String? text) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (text == null || text.isEmpty) {
      return '이메일을 입력하세요';
    } else if (!regex.hasMatch(text)) {
      return '올바른 이메일 형식이 아닙니다';
    }
    return null;
  }

  String? _validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return '비밀번호를 입력하세요';
    }
    return null;
  }

  String? _validatePasswordConfirm(String? text) {
    if (text == null || text.isEmpty) {
      return '비밀번호를 다시 입력하세요';
    } else if (text != _passwordTec.text.trim()) {
      return '비밀번호가 서로 일치하지 않습니다';
    }
    return null;
  }

  String? _validateUsername(String? text) {
    if (text == null || text.isEmpty) {
      return '유저명을 입력하세요';
    } else if (text.length < _minUsernameLength ||
        text.length > _maxUsernameLength) {
      return '유저명은 최소 $_minUsernameLength~$_maxUsernameLength글자로 작명해주세요';
    }
    return null;
  }

  _pickImage() async {
    // 이미지 선택
    final selected = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (selected == null) {
      return;
    }
    // 이미지 압축
    final dir = await getTemporaryDirectory();
    final compressed = await FlutterImageCompress.compressAndGetFile(
      selected.path,
      path.join(dir.path, "profile-image.jpg"),
      quality: 80,
    );
    setState(() {
      _selectedImage = File(compressed!.path);
    });
  }

  _unSelectImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  _checkUsername() {
    final username = _usernameTec.text.trim();
    if (username.isNotEmpty && username.length >= _minUsernameLength) {
      context.read<SignUpCubit>().checkUsername(_usernameTec.text.trim());
    }
  }

  _signUp() async {
    if (_selectedImage == null) {
      // TODO : snakbar 띄위기
      return;
    }
    // 입력값 검사
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    _formKey.currentState?.save();
    // 회원가입 처리
    await context.read<SignUpCubit>().signUpWithEmailAndPassword(
        email: _emailTec.text.trim(),
        password: _passwordTec.text.trim(),
        username: _usernameTec.text.trim(),
        profileImage: _selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 앱 로고
            Padding(
              padding: EdgeInsets.only(
                  top: CustomSpacing.xxl, bottom: CustomSpacing.lg),
              child: AppLogoWidget(
                fit: BoxFit.fitHeight,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),

            GestureDetector(
              onTap: _pickImage,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.width * 0.7,
                  child: CircleAvatar(
                    child: _selectedImage == null
                        ? Icon(
                            Icons.add_a_photo_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                            size: MediaQuery.of(context).size.width * 0.3,
                          )
                        : Stack(
                            children: [
                              CircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.width * 0.35,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                                backgroundImage: FileImage(_selectedImage!),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      size: CustomTextSize.xl,
                                    ),
                                    onPressed: _unSelectImage,
                                  ))
                            ],
                          ),
                  )),
            ),

            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomHeight.lg,
                    // 이메일
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: CustomSpacing.lg,
                          vertical: CustomSpacing.tiny),
                      child: TextFormField(
                        controller: _emailTec,
                        validator: _validateEmail,
                        maxLength: _maxEmailLength,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: '인증메일을 보낼 이메일 주소를 입력해주세요',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    // 비밀번호
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: CustomSpacing.lg,
                          vertical: CustomSpacing.tiny),
                      child: TextFormField(
                        controller: _passwordTec,
                        validator: _validatePassword,
                        maxLength: _maxPasswordLength,
                        maxLines: 1,
                        obscureText: !_isPasswordVisibile,
                        decoration: InputDecoration(
                            hintText: '비밀번호를 $_maxPasswordLength자 내로 작명해주세요',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                            prefixIcon: const Icon(Icons.key),
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordVisibile
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: _switchPasswordVisibility,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    // 비밀번호 확인
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: CustomSpacing.lg,
                          vertical: CustomSpacing.tiny),
                      child: TextFormField(
                        controller: _passwordConfirmTec,
                        validator: _validatePasswordConfirm,
                        maxLength: _maxPasswordLength,
                        maxLines: 1,
                        obscureText: !_isPasswordConfirmVisibile,
                        decoration: InputDecoration(
                            hintText: '비밀번호를 다시 입력해주세요',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                            prefixIcon: const Icon(Icons.key),
                            suffixIcon: IconButton(
                              icon: Icon(_isPasswordConfirmVisibile
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: _switchPasswordConfirmVisibility,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),

                    // 유저명
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: CustomSpacing.lg,
                          vertical: CustomSpacing.tiny),
                      child: TextFormField(
                        controller: _usernameTec,
                        validator: _validateUsername,
                        maxLength: _maxUsernameLength,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText:
                                '유저명은 $_minUsernameLength~$_maxUsernameLength자 내로 작명해주세요',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                            prefixIcon: const Icon(Icons.abc),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.check),
                              onPressed: _checkUsername,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: CustomSpacing.sm),
                      child: Divider(
                          indent: CustomSpacing.xxl,
                          endIndent: CustomSpacing.xxl),
                    ),

                    // 회원가입 버튼
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: CustomSpacing.lg,
                          vertical: CustomSpacing.sm),
                      child: BlocBuilder<SignUpCubit, SignUpState>(
                        builder: (context, state) {
                          return ElevatedButton(
                              onPressed: _signUp,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check, size: CustomTextSize.xl),
                                  CustomWidth.lg,
                                  Text(
                                      state.status == SignUpStatus.loading
                                          ? '로딩중...'
                                          : '회원가입하기',
                                      style: TextStyle(
                                          fontSize: CustomTextSize.xl))
                                ],
                              ));
                        },
                      ),
                    ),
                    CustomHeight.xxl
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
