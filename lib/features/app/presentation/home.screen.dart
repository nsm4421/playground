import 'package:flutter/material.dart';
import 'package:hot_place/features/app/dependency_injection/dependency_injection.dart';
import 'package:hot_place/features/user/domain/repository/credential.repository.dart';

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
