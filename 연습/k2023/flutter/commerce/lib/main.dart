import 'dependency_injection.dart';

import 'view/routes/routes.dart';
import 'package:flutter/material.dart';

import 'common/theme/custom/custom_theme_data.dart';

void main() {
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: router,
        theme: CustomThemeData.themeData,
      );
}
