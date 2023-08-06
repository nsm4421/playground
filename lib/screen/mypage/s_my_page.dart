import 'package:flutter/material.dart';
import 'package:flutter_sns/controller/auth_controller.dart';
import 'package:flutter_sns/screen/mypage/f_my_info.dart';
import 'package:flutter_sns/screen/mypage/f_my_post.dart';
import 'package:flutter_sns/model/my_info_dto.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});
  static final MyInfoDto _MOCK_MY_INFO = MyInfoDto(
      followingCount: 100,
      followerCount: 1000,
      postCount: 1,
      introduce: AuthController.to.user.value.description);

  AppBar _appBar() {
    return AppBar(
      title: Text(
        AuthController.to.user.value.nickname.toString(),
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
              thumbnailUrl: AuthController.to.user.value.thumbnail,
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
