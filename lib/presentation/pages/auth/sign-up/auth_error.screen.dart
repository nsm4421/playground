import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constant/enums/routes.enum.dart';

class AuthErrorScreen extends StatefulWidget {
  const AuthErrorScreen({super.key});

  @override
  State<AuthErrorScreen> createState() => _AuthErrorScreenState();
}

class _AuthErrorScreenState extends State<AuthErrorScreen> {
  _handleGoToLoginPage() => context.go(Routes.signIn.path);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text("Error",
                style: GoogleFonts.lobsterTwo(
                    fontSize: 50, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _handleGoToLoginPage,
        label: Text("Login페이지로",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold)),
      ));
}
