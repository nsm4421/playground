import 'package:flutter/material.dart';
import 'package:my_app/presentation/pages/home/view_modules/feed.view_module.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              FeedViewModule()
            ],
          ),
        ),
      ));
}
