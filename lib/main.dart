import 'package:flutter/material.dart';

import 'core/route/router.dart';
import 'core/theme/custom_theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
