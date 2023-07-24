import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/home/f_post.dart';
import 'package:flutter_sns/screen/home/f_story.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';

class HomeScreen extends StatelessWidget {
  static const double _LOGO_SIZE = 120;
  static const double _DIRECT_ICON_PADDING = 15;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appbar
      appBar: AppBar(
        elevation: 0,
        title: ImageIconWidget(imagePath: ImagePath.logo, size: _LOGO_SIZE),
        actions: [
          GestureDetector(
            // TODO : DM 아이콘 누를 때 동작 정의
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(_DIRECT_ICON_PADDING),
              child: ImageIconWidget(
                imagePath: ImagePath.directMessage,
              ),
            ),
          )
        ],
      ),

      /// body
      body: ListView(
        children: [StoryFragment(), PostFragment()],
      ),
    );
  }
}
