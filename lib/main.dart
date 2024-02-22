import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:hot_place/features/app/constant/route.constant.dart';
import 'package:hot_place/features/user/presentation/bloc/auth/auth.cubit.dart';
import 'features/app/theme/custom_palette.theme.dart';
import 'firebase_options.dart';
import 'features/app/dependency_injection/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 환경변수 불러오기
  await dotenv.load(fileName: ".env");

  // kakao sdk 초기화
  KakaoSdk.init(nativeAppKey: dotenv.get('KAKAO_NATIVE_APP_KEY'));

  // firebase 연동
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
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
      child: MaterialApp.router(
        routerConfig: routerConfig,
        title: 'Karma',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: CustomPalette.backgroundColor,
            dialogBackgroundColor: CustomPalette.appBarColor,
            appBarTheme: AppBarTheme(
              color: CustomPalette.appBarColor,
            )),
      ),
    );
  }
}
