import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/repository/auth.repository.dart';
import 'firebase_options.dart';
import 'package:my_app/presentation/features/auth/login.screen.dart';
import 'package:my_app/presentation/features/auth/register.screen.dart';
import 'package:my_app/presentation/features/home/home.screen.dart';
import 'package:my_app/presentation/features/splash/splash.screen.dart';

import 'controller/login.controller.dart';
import 'controller/register.controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthRepository(),permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData.dark()
          .copyWith(useMaterial3: true, scaffoldBackgroundColor: Colors.black),
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterScreen(),
          binding: BindingsBuilder(() {
            Get.put(RegisterController());
          }),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          binding: BindingsBuilder(() {
            Get.put(LoginController());
          }),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
        ),
      ],
    );
  }
}
