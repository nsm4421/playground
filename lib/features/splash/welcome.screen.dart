import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/constant/route.constant.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  goToLoginPage() => context.push(Routes.login.path);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Welcome Page")),
        body: Column(
          children: [
            Text("Welcome Page"),
            ElevatedButton(onPressed: goToLoginPage, child: Text("Continue..."))
          ],
        ),
      );
}
