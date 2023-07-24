import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/home/w_avatar.dart';

class StoryFragment extends StatelessWidget {
  static const double _AVATAR_SIZE = 60;
  static const double _PLUS_BUTTON_SIZE = 25;
  static const String _MOCK_IMAGE_URL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2OT6twSQM_jZlMBv6ix78oy5_HdmBaRS4S2dzAJhChBM5c-EbkhFGRYvnYT8uxPOWYZY&usqp=CAU';

  const StoryFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // 가로 스크롤
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          // 내 스토리 아바타
          Stack(
            children: [
              const MainStoryAvatarWidget(
                imagePath: _MOCK_IMAGE_URL,
                size: _AVATAR_SIZE + 5,
              ),
              Positioned(
                  right: 5,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        border: Border.all(color: Colors.white)),
                    width: _PLUS_BUTTON_SIZE,
                    height: _PLUS_BUTTON_SIZE,
                    child: const Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontSize: _PLUS_BUTTON_SIZE / 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ))
            ],
          ),
          // 다른 사람 스토리 아바타
          ...List.generate(
            100,
            (index) => const StoryAvatarWidget(
              imagePath: _MOCK_IMAGE_URL,
              size: _AVATAR_SIZE,
            ),
          )
        ]));
  }
}
