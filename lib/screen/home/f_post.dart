import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/home/w_avatar.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';

class PostFragment extends StatelessWidget {
  const PostFragment({super.key});

  static const double _SMALL_PADDING_SIZE = 8;
  static const double _BIG_PADDING_SIZE = 15;
  static const double _ICON_SIZE = 30;
  static const double _BIG_FONTSIZE = 18;
  static const double _SMALL_FONTSIZE = 15;

  static const double _AVATAR_SIZE = 40;
  static const double _MOREICON_SIZE = 25;
  static const String _MOCK_NICKNAME = 'TEST NICKNAME';
  static const String _MOCK_IMAGE_URL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2OT6twSQM_jZlMBv6ix78oy5_HdmBaRS4S2dzAJhChBM5c-EbkhFGRYvnYT8uxPOWYZY&usqp=CAU';
  static const _MOCK_COMMENTS = ["테스트 댓글", "테스트다", "test"];

  Widget _header(String? nickname) {
    return Padding(
      padding: const EdgeInsets.all(_SMALL_PADDING_SIZE),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: _SMALL_PADDING_SIZE, right: _SMALL_PADDING_SIZE),
            child: StoryAvatarWidget(
                size: _AVATAR_SIZE, imagePath: _MOCK_IMAGE_URL),
          ),
          if (nickname != null)
            Text(
              nickname,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: _BIG_FONTSIZE),
            ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(_SMALL_PADDING_SIZE),
            child: ImageIconWidget(
              imagePath: ImagePath.postMoreIcon,
              size: _MOREICON_SIZE,
            ),
          )
        ],
      ),
    );
  }

  Widget _postBody(String imageUrl) {
    return Container(
      color: Colors.black12,
      width: double.infinity,
      child: CachedNetworkImage(imageUrl: imageUrl),
    );
  }

  Widget _postIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _SMALL_PADDING_SIZE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ImageIconWidget(
                imagePath: ImagePath.likeOffIcon,
                size: _ICON_SIZE,
              ),
              const SizedBox(
                width: _SMALL_PADDING_SIZE,
              ),
              ImageIconWidget(
                imagePath: ImagePath.replyIcon,
                size: _ICON_SIZE,
              ),
              const SizedBox(
                width: _SMALL_PADDING_SIZE,
              ),
              ImageIconWidget(
                imagePath: ImagePath.directMessage,
                size: _ICON_SIZE,
              ),
              const Expanded(child: SizedBox()),
              ImageIconWidget(imagePath: ImagePath.bookMarkOffIcon),
            ],
          ),
          SizedBox(height: _SMALL_PADDING_SIZE,),
          const Text(
            "좋아요 40개",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: _SMALL_FONTSIZE),
          )
        ],
      ),
    );
  }

  Widget _comments() {
    return Padding(
      padding: const EdgeInsets.all(_SMALL_PADDING_SIZE),
      child: Column(
        children: [
          ... _MOCK_COMMENTS.map((e) => Row(
            children: [
              // TODO : 닉네임/댓글 정보 박기
              Text('Karma', style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: _SMALL_PADDING_SIZE,),
              Text(e)
            ],
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: List.generate(
            100,
            (index) => Padding(
                  padding: const EdgeInsets.only(top: _BIG_PADDING_SIZE),
                  child: Column(
                    children: [
                      _header(_MOCK_NICKNAME),
                      const SizedBox(
                        height: _SMALL_PADDING_SIZE,
                      ),
                      _postBody(_MOCK_IMAGE_URL),
                      const SizedBox(
                        height: _BIG_PADDING_SIZE,
                      ),
                      _postIcons(),
                      _comments()
                    ],
                  ),
                )),
      ),
    );
  }
}
