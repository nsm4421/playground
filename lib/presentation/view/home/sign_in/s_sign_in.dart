part of 'index.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // 폼
  late GlobalKey<FormState> _formKey;

  // 로딩
  bool _showLoading = false;
  late SMITrigger checkSMITrigger;
  late SMITrigger errorSMITrigger;
  late SMITrigger resetSMITrigger;

  // 이메일
  static const _emailMaxLength = 30;
  final _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  late TextEditingController _emailController;
  late FocusNode _emailFocus;

  // 비밀번호
  static const _passwordMaxLength = 30;
  late TextEditingController _passwordController;
  late FocusNode _passwordFocus;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(text: context.read<SignInCubit>().state.email);
    _passwordController =
        TextEditingController(text: context.read<SignInCubit>().state.password);
    _emailFocus = FocusNode(debugLabel: 'sign-in-email-text-field')
      ..addListener(_handleEmailFocus);
    _passwordFocus = FocusNode(debugLabel: 'sign-in-password-text-field')
      ..addListener(_handlePasswordFocus);
    _formKey = GlobalKey<FormState>(debugLabel: 'sign-in-form-key');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus
      ..removeListener(_handleEmailFocus)
      ..dispose();
    _passwordFocus
      ..removeListener(_handlePasswordFocus)
      ..dispose();
  }

  _handlePasswordVisible() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  _handleEmailFocus() {
    setState(() {});
    if (!_emailFocus.hasFocus) {
      context.read<SignInCubit>().edit(email: _emailController.text.trim());
    }
  }

  _handlePasswordFocus() {
    setState(() {});
    if (!_passwordFocus.hasFocus) {
      context
          .read<SignInCubit>()
          .edit(password: _passwordController.text.trim());
    }
  }

  String? _handleValidateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return 'send email';
    } else if (!_emailRegex.hasMatch(text)) {
      return 'not valid email';
    }
    return null;
  }

  String? _handleValidatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return 'send password';
    }
    return null;
  }

  _handleOnInitRiveAsset(Artboard artBoard) {
    final controller =
        StateMachineController.fromArtboard(artBoard, 'State Machine 1')!;
    artBoard.addController(controller);
    checkSMITrigger = controller.findSMI('Check') as SMITrigger;
    errorSMITrigger = controller.findSMI('Error') as SMITrigger;
    resetSMITrigger = controller.findSMI('Reset') as SMITrigger;
  }

  _handlePop() {
    context.pop();
  }

  // TODO : 이메일,비밀번호 로그인
  _handleClickSignInButton() async {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    setState(() {
      _showLoading = true;
    });
    await Future.delayed(500.ms, () async {
      context.read<SignInCubit>().signIn();
    });
  }

  // TODO : 회원가입 페이지로 라우팅
  _handleRoute() {}

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (prev, curr) => prev.status == Status.loading,
      listener: (context, state) async {
        switch (state.status) {
          case Status.success:
            checkSMITrigger.fire();
          case Status.error:
            errorSMITrigger.fire();
          default:
            return;
        }
        await Future.delayed(2.sec, () {
          setState(() {
            _showLoading = false;
          });
        });
      },
      child: Center(
        child: Container(
          height: context.height * 2 / 3,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: CustomPalette.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (24.0).h,

                    /// 헤더
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check,
                          size: 25,
                        ),
                        (12.0).w,
                        Text(
                          'Sign In',
                          style: context.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    const Spacer(flex: 2),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          /// 이메일
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: TextFormField(
                              controller: _emailController,
                              validator: _handleValidateEmail,
                              focusNode: _emailFocus,
                              maxLength: _emailMaxLength,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.email_outlined,
                                      color: _emailFocus.hasFocus
                                          ? context.colorScheme.primary
                                              .withOpacity(0.5)
                                          : null,
                                    ),
                                  ),
                                  labelText: 'Email',
                                  counterText: ''),
                            ),
                          ),

                          /// 비밀번호
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: TextFormField(
                              controller: _passwordController,
                              validator: _handleValidatePassword,
                              focusNode: _passwordFocus,
                              maxLength: _passwordMaxLength,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.key_outlined,
                                        color: _passwordFocus.hasFocus
                                            ? context.colorScheme.primary
                                                .withOpacity(0.5)
                                            : null),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: _handlePasswordVisible,
                                      icon: _isPasswordVisible
                                          ? Icon(
                                              Icons.visibility_off_outlined,
                                              color: _passwordFocus.hasFocus
                                                  ? context.colorScheme.primary
                                                      .withOpacity(0.5)
                                                  : null,
                                            )
                                          : Icon(
                                              Icons.visibility_outlined,
                                              color: _passwordFocus.hasFocus
                                                  ? context.colorScheme.primary
                                                      .withOpacity(0.5)
                                                  : null,
                                            )),
                                  labelText: 'Password',
                                  counterText: ''),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// 로그인 버튼
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: ElevatedButton(
                          onPressed:
                              _showLoading ? null : _handleClickSignInButton,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: context
                                  .colorScheme.primaryContainer
                                  .withOpacity(0.5),
                              minimumSize: const Size(double.infinity, 50)),
                          child: Text(
                            'Sign In',
                            style: context.textTheme.titleMedium?.copyWith(
                                color: context.colorScheme.onPrimary),
                          )),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: [
                          const Expanded(child: Divider()),
                          Text('OR',
                              style: context.textTheme.labelMedium
                                  ?.copyWith(color: CustomPalette.mediumGrey)),
                          const Expanded(child: Divider()),
                        ],
                      ),
                    ),

                    /// 회원가입 버튼
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "if you don't have account yet",
                            style: context.textTheme.labelLarge,
                          ),
                          (12.0).h,
                          ElevatedButton(
                            onPressed: _showLoading ? null : _handleRoute,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: context
                                    .colorScheme.secondaryContainer
                                    .withOpacity(0.5),
                                minimumSize: const Size(double.infinity, 50)),
                            child: Text(
                              'Sign Up',
                              style: context.textTheme.titleMedium?.copyWith(
                                  color: context.colorScheme.onSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// 닫기 버튼
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -50,
                  child: CircleAvatar(
                    radius: 50 / 2,
                    backgroundColor: CustomPalette.white,
                    child: IconButton(
                      onPressed: _handlePop,
                      icon: Icon(
                        Icons.clear,
                        color: CustomPalette.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),

                /// 로딩
                if (_showLoading)
                  Positioned.fill(
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: RiveAnimation.asset(Assets.rive.check,
                              onInit: _handleOnInitRiveAsset),
                        ),
                        const Spacer()
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
