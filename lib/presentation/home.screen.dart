import 'package:flutter/material.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/domain/repository/user/credential.repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  getIt<CredentialRepository>().signOut();
                },
                child: Text("TSET"))
          ],
        ),
      );
}
