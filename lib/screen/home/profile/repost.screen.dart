import 'package:flutter/material.dart';

class RepostFragment extends StatelessWidget {
  const RepostFragment({super.key});

  @override
  Widget build(BuildContext context) => const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("REPOST"),
            ],
          ),
        ),
      );
}
