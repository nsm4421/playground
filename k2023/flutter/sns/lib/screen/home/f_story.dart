import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/home/w_avatar.dart';
import 'package:flutter_sns/util/common_size.dart';

class StoryFragment extends StatelessWidget {
  static const String _MOCK_IMAGE_URL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2OT6twSQM_jZlMBv6ix78oy5_HdmBaRS4S2dzAJhChBM5c-EbkhFGRYvnYT8uxPOWYZY&usqp=CAU';

  const StoryFragment({super.key});

  // 내 스토리 아바타
  Widget _myAvatar() {
    return Stack(
      children: [
        MainStoryAvatarWidget(
          imagePath: _MOCK_IMAGE_URL,
          size: CommonSize.avatar4xl + 5,
        ),
        Positioned(
            right: 5,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  border: Border.all(color: Colors.white)),
              width: CommonSize.avatarXl,
              height: CommonSize.avatarXl,
              child: Center(
                child: Text(
                  "+",
                  style: TextStyle(
                      fontSize: CommonSize.avatarXl / 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ))
      ],
    );
  }

// 다른 사람 스토리 아바타
  List<Widget> _othersAvatars() {
    return List.generate(
      100,
      (index) => StoryAvatarWidget(
        imagePath: _MOCK_IMAGE_URL,
        size: CommonSize.avatar4xl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, // 가로 스크롤
        child: Row(children: [_myAvatar(), ..._othersAvatars()]));
  }
}
