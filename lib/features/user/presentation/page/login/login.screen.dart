import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/features/app/dependency_injection/dependency_injection.dart';
import 'package:hot_place/features/user/presentation/bloc/sign_up/sign_up.bloc.dart';
import 'package:hot_place/features/user/presentation/bloc/sign_up/sign_up.event.dart';
import 'package:hot_place/features/user/presentation/page/login/welcome.screen.dart';

import '../../bloc/sign_up/sign_up.state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<SignUpBloc>()..add(InitSignUpEvent()),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            // TODO : 로딩중, 에러 UI
            // 로딩중
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // 에러
            if (state.isError) {
              return Center(
                  child: Column(
                children: [
                  Text("ERROR"),
                  ElevatedButton(
                      onPressed: () {
                        context.read<SignUpBloc>().add(InitSignUpEvent());
                      },
                      child: Text("BACK"))
                ],
              ));
            }
            // 환영 페이지
            return const WelcomeScreen();
          },
        ),
      );
}
