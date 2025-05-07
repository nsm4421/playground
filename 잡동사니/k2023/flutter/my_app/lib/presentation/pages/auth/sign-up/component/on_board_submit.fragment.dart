import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.bloc.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.event.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';

class OnBoardingSubmitFragment extends StatelessWidget {
  const OnBoardingSubmitFragment({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
      builder: (_, state) => _OnBoardSubmitFragmentView(state));
}

class _OnBoardSubmitFragmentView extends StatefulWidget {
  const _OnBoardSubmitFragmentView(this.state, {super.key});

  final SignUpState state;

  @override
  State<_OnBoardSubmitFragmentView> createState() =>
      _OnBoardSubmitFragmentViewState();
}

class _OnBoardSubmitFragmentViewState
    extends State<_OnBoardSubmitFragmentView> {
  static const int _duration = 2;

  bool _validate() {
    if (widget.state.user.nickname == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("닉네임을 입력해주세요"),
          duration: const Duration(seconds: _duration),
          action: SnackBarAction(
            label: '바로가기',
            onPressed: () {},
          ),
        ),
      );
      return false;
    }
    return true;
  }

  _handleSubmit() {
    context.read<SignUpBloc>().add(SubmitOnBoardingFormEvent());
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            Text("Let's go~!",
                style: GoogleFonts.lobsterTwo(
                    fontSize: 50, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("회원정보 입력이 완료되었습니다!",
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  "제출하기",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
}
