import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/route.constant.dart';

class PostFragment extends StatelessWidget {
  const PostFragment({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text("POST"),
          ElevatedButton(
              onPressed: () {
                context.push(Routes.addPost.path);
              },
              child: Text("TEST"))
        ],
      );
}
