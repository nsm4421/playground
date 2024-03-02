import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hot_place/core/constant/route.constant.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'core/theme/custom_palette.theme.dart';
import 'firebase_options.dart';
import 'core/di/dependency_injection.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 로컬 서버
  InAppLocalhostServer server = InAppLocalhostServer(port: 8080);
  server.start();

  // 환경변수 불러오기
  await dotenv.load();

  // kakao sdk 초기화
  AuthRepository.initialize(appKey: dotenv.env['KAKAO_JS_APP_KEY'] ?? '');

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
  Widget build(BuildContext context) => MaterialApp.router(
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
}
