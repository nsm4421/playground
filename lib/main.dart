import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/common/theme/themes.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:chat_app/screen/s_error.dart';
import 'package:chat_app/screen/s_home.dart';
import 'package:chat_app/screen/s_loading.dart';
import 'package:chat_app/screen/s_welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Themes();
    return MaterialApp(
        onGenerateRoute: CustomRoutes.onGeneralRoute,
        debugShowCheckedModeBanner: false,
        title: "Chat App",
        themeMode: ThemeMode.system,
        theme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        home: ref.watch(currentAuthProvider).when(
            // 로그인 안된 경우 WelcomeScreen, 로그인한 경우 HomeScreen
            data: (user) =>
                user == null ? const WelcomeScreen() : const HomeScreen(),
            // 에러 발생시
            error: (error, trace) =>
                ErrorScreen(errorMessage: error.toString()),
            // 로딩 중
            loading: () => const LoadingScreen()));
  }
}
