part of 'index.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late RiveAnimationController _buttonController;
  bool _isFormExposed = false;

  @override
  void initState() {
    super.initState();
    _buttonController = OneShotAnimation('active', autoplay: false);
  }

  @override
  void dispose() {
    super.dispose();
    _buttonController.dispose();
  }

  _handleClickLoginButton() async {
    _buttonController.isActive = true;
    setState(() {
      _isFormExposed = true;
    });
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: CustomPalette.darkGrey,
        barrierLabel: 'home-screen-barrier',
        transitionDuration: 500.ms,
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                Tween(begin: const Offset(0, -1), end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
        pageBuilder: (_, __, ___) => const SignInPage()).then((_) {
      setState(() {
        _isFormExposed = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 배경
          RiveAnimation.asset(Assets.rive.shapes),
          Positioned.fill(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 15),
                  child: const SizedBox())),

          AnimatedPositioned(
            // 로그인 화면이 노출된 동안, 홈 화면을 위로 당기기
            duration: 500.ms,
            top: _isFormExposed ? -context.height / 3 : 0,
            height: context.height,
            width: context.width,
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),

                /// 제목
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Karma',
                          style: context.textTheme.displayLarge,
                        ),
                        (24.0).h,
                        Text(
                          'welcome to my dating app',
                          style: context.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                /// 로그인 버튼
                GestureDetector(
                  onTap: _handleClickLoginButton,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      width: 260,
                      height: 64,
                      child: Stack(
                        children: [
                          RiveAnimation.asset(
                            Assets.rive.button,
                            controllers: [_buttonController],
                          ),
                          Positioned.fill(
                            top: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.arrow_forward, size: 30),
                                (12.0).w,
                                Text(
                                  "Let's go",
                                  style: context.textTheme.titleLarge,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 36, left: 24),
                  child: Text(
                    'To start, click the button',
                    style: context.textTheme.labelLarge,
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}
