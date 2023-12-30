import 'package:flutter/material.dart';

class FollowerFragment extends StatelessWidget {
  const FollowerFragment({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("FOLLOW"),
            ],
          ),
        ),
      );
}
