import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/data/data_source/remote/auth/auth.api.dart';

import '../../../../core/constant/asset_path.dart';
import '../../../../core/constant/enums/routes.enum.dart';
import '../../../../dependency_injection.dart';
import 'bloc/sign_up.bloc.dart';
import 'bloc/sign_up.event.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 50),
              SvgPicture.asset(AssetPath.appLogo,
                  color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 30),
              const Text("채팅 앱에 오신걸 환영합니다", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              const _GoogleSignUpButton(),
              const Spacer(),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              const Text("nsm4421@gmail.com",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 10)
            ],
          ),
        ),
      );
}

/// 구글 계정을 회원가입 및 로그인 버튼
class _GoogleSignUpButton extends StatefulWidget {
  const _GoogleSignUpButton({super.key});

  @override
  State<_GoogleSignUpButton> createState() => _GoogleSignUpButtonState();
}

class _GoogleSignUpButtonState extends State<_GoogleSignUpButton> {
  _handleSignUp() {
    getIt<SignUpBloc>().add(GoogleSignUpEvent());
    if (getIt<AuthApi>().currentUser != null) {
      context.go(Routes.main.path);
    }
  }

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: _handleSignUp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AssetPath.googleLogo),
          const SizedBox(width: 10),
          Text("Google계정으로 사용하기",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700))
        ],
      ));
}
