import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constant/route.constant.dart';
import 'core/di/dependency_injection.dart';
import 'core/theme/custom_palette.theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 의존성 주입
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // 앱 전역에서 접근 가능한 Bloc 접근
        providers: [
        ],
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
}
