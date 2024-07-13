import 'dart:io';

import 'package:flutter/material.dart';
import 'core/config/no_check_certification.dart';
import 'core/constant/route.constant.dart';
import 'core/di/dependency_injection.dart';
import 'core/theme/custom_palette.theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 의존성 주입
  configureDependencies();

  // 인증서 확인 무시 옵션
  HttpOverrides.global = NoCheckCertificateHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: routerConfig,
        title: 'Karma',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: CustomPalette.backgroundColor,
            dialogBackgroundColor: CustomPalette.appBarColor,
            appBarTheme: AppBarTheme(
              color: CustomPalette.appBarColor,
            )));
  }
}
