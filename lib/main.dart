import 'package:flutter/material.dart';
import 'presentation/routes/router_config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: routerConfig,
      );
}
