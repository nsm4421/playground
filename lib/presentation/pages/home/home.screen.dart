import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/presentation/pages/home/view_modules/feed.view_module.dart';

import '../../../core/constant/enums/routes.enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _handleGoToWriteFeed() => context.push(Routes.feed.path);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
        actions: [
          IconButton(
              onPressed: _handleGoToWriteFeed,
              icon: Icon(
                Icons.add_box_outlined,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [],
          ),
        ),
      ));
}
