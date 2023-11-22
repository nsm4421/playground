import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.bloc.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.event.dart';

class OnBoardSubmitScreen extends StatefulWidget {
  const OnBoardSubmitScreen({super.key});

  @override
  State<OnBoardSubmitScreen> createState() => _OnBoardSubmitScreenState();
}

class _OnBoardSubmitScreenState extends State<OnBoardSubmitScreen> {

  _handleSubmit(){
    context.read<SignUpBloc>().add(SubmitUserInfoEvent());
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
                onPressed: () {},
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
                )),
          ],
        ),
      );
}
