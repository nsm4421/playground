import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.bloc.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';

class WelcomeFragment extends StatefulWidget {
  const WelcomeFragment({super.key});

  @override
  State<WelcomeFragment> createState() => _WelcomeFragmentState();
}

class _WelcomeFragmentState extends State<WelcomeFragment> {
  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
        builder: (_, state) => Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Text("On Boarding",
                  style: GoogleFonts.lobsterTwo(
                      fontWeight: FontWeight.w700, fontSize: 50)),
            ),
            const SizedBox(height: 50),
            Text(state.user.email,
                style: GoogleFonts.lobster(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 10),
            Text("회원가입에 성공했습니다", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 50),
            Text("앱을 이용하기 전 정보를 등록해주세요",
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 50),
          ],
        ),
      );
}
