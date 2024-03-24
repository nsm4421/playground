import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hot_place/core/constant/route.constant.dart';
import 'core/theme/custom_palette.theme.dart';
import 'core/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 환경변수 불러오기
  await dotenv.load();

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
