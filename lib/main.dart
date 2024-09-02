import 'package:flutter/material.dart';
import 'package:flutter_app/auth/presentation/pages/sign_in/sign_in.page.dart';
import 'package:flutter_app/shared/config/di/dependency_injection.dart';
import 'package:flutter_app/shared/style/style.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

main() async {
  // 환경변수 불러오기
  await dotenv.load();

  // supabase client 초기화
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // 의존성 주입
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNS APP',
      theme: CustomLightTheme().theme,
      darkTheme: CustomDarkTheme().theme,
      home: const SignInPage(),
    );
  }
}
