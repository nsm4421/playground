import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/s_home.dart';
import 'package:flutter_sns/util/init_binding.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black)),
        useMaterial3: true,
      ),
      initialBinding: InitBinding(),
      home: const HomeScreen(),
    );
  }
}