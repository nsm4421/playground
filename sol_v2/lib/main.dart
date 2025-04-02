import 'package:flutter/material.dart';

import 'visualization_summary/presentation/visualization_summary.screen.dart';
import 'visualization_summary/domain/entity/product_info.entity.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLv2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: VisualizationSummaryScreen(dummyProduct),
    );
  }
}
