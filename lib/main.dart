import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hot_place/core/constant/route.constant.dart';
import 'package:hot_place/presentation/auth/bloc/auth.bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/custom_palette.theme.dart';
import 'core/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 환경변수 불러오기
  await dotenv.load();

  // supabase 초기화
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_PROJECT_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!);

  // 의존성 주입
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      // 앱 전역에서 Auth Bloc 접근
      create: (context) => getIt<AuthBloc>()..add(InitAuthEvent()),
      child: MaterialApp.router(
          routerConfig: routerConfig,
          title: 'Karma',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: CustomPalette.backgroundColor,
              dialogBackgroundColor: CustomPalette.appBarColor,
              appBarTheme: AppBarTheme(
                color: CustomPalette.appBarColor,
              ))));
}
