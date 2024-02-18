import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hot_place/features/app/constant/route.constant.dart';
import 'features/app/theme/custom_palette.theme.dart';
import 'firebase_options.dart';

void  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        )
      ),
    );
  }
}
