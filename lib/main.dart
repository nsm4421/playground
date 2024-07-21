import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/route/router.dart';
import 'core/theme/custom_theme_data.dart';

Future<void> main() async {
  // splash 이미지
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 환경변수 불러오기
  await dotenv.load();

  // supabase 초기화
  await Supabase.initialize(
      url: dotenv.env["SUPABASE_URL"]!,
      anonKey: dotenv.env["SUPABASE_ANON_KEY"]!);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
