import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  goToLoginPage(){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title:Text("Welcome Page")
    ),
    body: Column(
      children: [
        Text("Welcome Page"),
        ElevatedButton(onPressed: (){}, child: Text("Continue..."))
      ],
    ),
  );
}
