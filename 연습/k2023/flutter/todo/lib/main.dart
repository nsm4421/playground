import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management_tutorial/screen/s_home.dart';
import 'package:state_management_tutorial/utils/init_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter State Management Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      initialBinding: InitBinding(),
    );
  }
}
