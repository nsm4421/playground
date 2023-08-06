import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/mypage/f_my_info.dart';
import 'package:flutter_sns/screen/mypage/f_my_post.dart';
import 'package:flutter_sns/model/my_info_dto.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  static const String _MOCK_IMAGE_URL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2OT6twSQM_jZlMBv6ix78oy5_HdmBaRS4S2dzAJhChBM5c-EbkhFGRYvnYT8uxPOWYZY&usqp=CAU';
  static final MyInfoDto _MOCK_MY_INFO = MyInfoDto(
      followingCount: 100,
      followerCount: 1000,
      postCount: 1,
      introduce: "자기소개 글 \n 안녕하세요~~~~");

  AppBar _appBar() {
    return AppBar(
      title: Text(
        "Nickname",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: CommonSize.fontsizeXl),
      ),
      actions: [
        GestureDetector(
            onTap: () {},
            child: ImageIconWidget(imagePath: ImagePath.uploadIcon)),
        SizedBox(
          width: CommonSize.marginLg,
        ),
        GestureDetector(
            onTap: () {},
            child: ImageIconWidget(
              imagePath: ImagePath.menuIcon,
            )),
        SizedBox(
          width: CommonSize.marginMd,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyInfoFragment(
              thumbnailUrl: _MOCK_IMAGE_URL,
              myInfoVo: _MOCK_MY_INFO,
            ),
            SizedBox(
              height: CommonSize.margin2Xl,
            ),
            MyPostFragment()
          ],
        ),
      ),
    );
  }
}
