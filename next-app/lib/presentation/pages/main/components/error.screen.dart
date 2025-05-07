import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("ERROR", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  if (context.mounted) {
                    context.pop();
                  }
                },
                child: Text("Go Back"))
          ],
        ),
      ),
    );
  }
}
