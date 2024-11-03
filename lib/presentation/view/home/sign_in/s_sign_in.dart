part of 'index.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // 폼
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>(debugLabel: 'sign-in-form-key');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              /// 회원가입 양식
              SignInFormFragment(_formKey),

              /// 로그인 버튼
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SubmitButtonWidget(_formKey),
              ),

              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: DividerWidget(label: 'OR')),

              /// 회원가입 버튼
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: RouteToSignUpButtonWidget(),
              ),
            ],
          ),

          /// 닫기 버튼
          const CloseButtonWidget(),
        ],
      ),
    );
  }
}
