import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/features/app/constant/route.constant.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';
import 'package:hot_place/features/user/presentation/bloc/auth/auth.cubit.dart';
import 'features/app/theme/custom_palette.theme.dart';
import 'firebase_options.dart';
import 'features/app/dependency_injection/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase 연동
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 의존성 주입
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 앱 전역에서 인증상태 cubit에 접근
      create: (context) => getIt<AuthCubit>()..startApp(),
      child: StreamBuilder<User?>(
          stream: getIt<AuthCubit>().currentUserStream,
          builder: (ctx, snapshot) {
            // 로딩중
            if (snapshot.connectionState != ConnectionState.active) {
              return const Center(child: CircularProgressIndicator());
            }

            // 유저정보가 없는 경우, 로그아웃 처리 후 로그인 페이지로 라우팅
            final user = snapshot.data;
            if (getIt<AuthCubit>().state.status == AuthStatus.authenticated &&
                user == null) {
              getIt<AuthCubit>().logout();
              context.go(Routes.login.path);
            }

            return MaterialApp.router(
              routerConfig: routerConfig,
              title: 'Karma',
              debugShowCheckedModeBanner: false,
              theme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: CustomPalette.backgroundColor,
                  dialogBackgroundColor: CustomPalette.appBarColor,
                  appBarTheme: AppBarTheme(
                    color: CustomPalette.appBarColor,
                  )),
            );
          }),
    );
  }
}
