import 'package:flutter/material.dart';

class FollowingFragment extends StatelessWidget {
  const FollowingFragment({super.key});

  @override
  Widget build(BuildContext context) => const SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("REPLY"),
        ],
      ),
    ),
  );
}
