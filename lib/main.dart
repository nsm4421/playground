import 'package:chat_app/screen/s_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Chat App",
        theme: ThemeData.dark(useMaterial3: true),
        home: const HomeScreen());
  }
}
