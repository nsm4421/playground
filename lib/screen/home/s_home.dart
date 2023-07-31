import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/home/f_post.dart';
import 'package:flutter_sns/screen/home/f_story.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "My Instagram",
        style: GoogleFonts.lobsterTwo(fontSize: CommonSize.logoSize),
      ),
      actions: [
        GestureDetector(
          // TODO : DM 아이콘 누를 때 동작 정의
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ImageIconWidget(
              imagePath: ImagePath.directMessage,
            ),
          ),
        )
      ],
    );
  }

  Widget _body() {
    return ListView(
      children: const [StoryFragment(), PostFragment()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }
}
