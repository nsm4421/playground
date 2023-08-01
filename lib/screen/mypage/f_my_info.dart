import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/home/w_avatar.dart';
import 'package:flutter_sns/screen/mypage/vo_my_info.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';

class MyInfoFragment extends StatelessWidget {
  const MyInfoFragment(
      {super.key, required this.thumbnailUrl, required this.myInfoVo});

  final String thumbnailUrl;
  final MyInfoVo myInfoVo;

  Widget _infoItem({required String title, required int count}) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
              fontSize: CommonSize.fontsizeLg, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: TextStyle(fontSize: CommonSize.fontsizeMd),
        )
      ],
    );
  }

  Widget _info(MyInfoVo vo) {
    return Row(
      children: [
        MainStoryAvatarWidget(
            imagePath: thumbnailUrl, size: CommonSize.avatar6xl),
        SizedBox(
          width: CommonSize.marginXl,
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _infoItem(title: "Post", count: vo.postCount),
            _infoItem(title: "Followers", count: vo.followerCount),
            _infoItem(title: "Following", count: vo.followingCount),
          ],
        ))
      ],
    );
  }

  Widget _introduce(String introduce) {
    return Padding(
      padding: EdgeInsets.all(CommonSize.paddingMd),
      child: Text(
        introduce,
        style: TextStyle(
            fontSize: CommonSize.fontsizeMd, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _editProfile() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: CommonSize.marginLg),
            padding: EdgeInsets.symmetric(
                horizontal: CommonSize.paddingLg,
                vertical: CommonSize.paddingMd),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xffdedede),
                )),
            child: Center(
              child: Text(
                "Edit Profile",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: CommonSize.fontsizeMd,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(
          width: CommonSize.marginLg,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(0xffdedede),
              )),
          child: ImageIconWidget(
            imagePath: ImagePath.addFriend,
            size: CommonSize.iconSizeLg,
          ),
        ),
        SizedBox(
          width: CommonSize.marginLg,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _info(myInfoVo),
        SizedBox(
          height: CommonSize.marginLg,
        ),
        if (myInfoVo.introduce != null) _introduce(myInfoVo.introduce!),
        SizedBox(
          height: CommonSize.marginMd,
        ),
        _editProfile(),
      ],
    );
  }
}
