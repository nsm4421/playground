part of "sign-up.page.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;
  late TextEditingController _passwordConfirmTec;
  late ImagePicker _imagePicker;
  XFile? _xFile;
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _imagePicker = ImagePicker();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _passwordConfirmTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
    _passwordConfirmTec.dispose();
  }

  _handlePasswordVisibility() => setState(() {
        _isPasswordVisible = !_isPasswordVisible;
      });

  _handlePasswordConfirmVisibility() => setState(() {
        _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
      });

  String? _handleValidateEmail(String? value) {
    if (value == null) {
      return "Send Email";
    } else {
      const pattern =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$";
      final regExp = RegExp(pattern);
      return regExp.hasMatch(value) ? null : "Not Valid Email Address";
    }
  }

  String? _handleValidatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Send Password";
    } else {
      return value.length >= 6 ? null : "Password Is Too Short";
    }
  }

  String? _handleValidatePasswordConfirm(String? value) {
    return _passwordTec.text == _passwordConfirmTec.text
        ? null
        : "Password Is Not Matched";
  }

  _handleSelectImage() async {
    final selected = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selected != null) {
      setState(() {
        _xFile = selected;
      });
    }
  }

  _handleUnSelectImage() {
    setState(() {
      _xFile = null;
    });
  }

  /// 회원가입 처리
  Future<void> _handleSubmit() async {
    // 프로필 이미지 등록 여부 검사
    if (_xFile == null) {
      Fluttertoast.showToast(
          msg: "profile image is necessary",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP);
      return;
    }
    // 회원가입 양식 검사
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) {
      Fluttertoast.showToast(
          msg: "check form again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP);
    } else {
      // 회원가입 이벤트 발생
      context.read<AuthBloc>().add(SignUpWithEmailAndPasswordEvent(
          profileImage: File(_xFile!.path),
          email: _emailTec.text.trim(),
          password: _passwordTec.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign UP"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// 프로필 이미지
              _xFile?.path == null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: _handleSelectImage,
                        child: Column(
                          children: [
                            Icon(Icons.add_a_photo_outlined,
                                color: Theme.of(context).colorScheme.primary),
                            Text("Profile Image",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                            Text("need picture to sign up",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary))
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundImage:
                                      FileImage(File(_xFile!.path)),
                                  radius:
                                      MediaQuery.of(context).size.width / 4),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  icon: Icon(Icons.clear,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  onPressed: _handleUnSelectImage))
                        ],
                      ),
                    ),

              /// 이메일
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: _handleValidateEmail,
                  controller: _emailTec,
                  decoration: InputDecoration(
                      labelText: "EMAIL",
                      helperText: "initial nickname is email",
                      helperStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.tertiary),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: Theme.of(context).colorScheme.primary),
                ),
              ),

              /// 비밀번호
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: !_isPasswordVisible,
                  validator: _handleValidatePassword,
                  controller: _passwordTec,
                  decoration: InputDecoration(
                      labelText: "PASSWORD",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: _handlePasswordVisibility,
                        icon: _isPasswordVisible
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.blueGrey,
                              )
                            : const Icon(Icons.visibility,
                                color: Colors.blueGrey),
                      ),
                      prefixIconColor: Theme.of(context).colorScheme.primary),
                ),
              ),

              /// 비밀번호 확인
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: !_isPasswordConfirmVisible,
                  validator: _handleValidatePasswordConfirm,
                  controller: _passwordConfirmTec,
                  decoration: InputDecoration(
                      labelText: "PASSWORD CONFIRM",
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: _handlePasswordConfirmVisibility,
                        icon: _isPasswordConfirmVisible
                            ? const Icon(Icons.visibility_off,
                                color: Colors.blueGrey)
                            : const Icon(Icons.visibility,
                                color: Colors.blueGrey),
                      ),
                      prefixIconColor: Theme.of(context).colorScheme.primary),
                ),
              ),

              /// 제출버튼
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context)
                              .colorScheme
                              .primaryContainer), // 배경 색상 설정
                    ),
                    onPressed: _handleSubmit,
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text("SUBMIT",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
