import 'package:flutter/material.dart';
import 'package:my_app/core/theme/custom_theme_data.dart';
import 'presentation/routes/router_config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: routerConfig,
        theme: CustomThemeData.themeData,
      );
}
