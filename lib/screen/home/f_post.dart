import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sns/screen/home/w_avatar.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';

class PostFragment extends StatelessWidget {
  const PostFragment({super.key});

  // static const double _SMALL_FONTSIZE = 15;
  static const String _MOCK_NICKNAME = 'TEST NICKNAME';
  static const String _MOCK_IMAGE_URL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2OT6twSQM_jZlMBv6ix78oy5_HdmBaRS4S2dzAJhChBM5c-EbkhFGRYvnYT8uxPOWYZY&usqp=CAU';
  static const _MOCK_COMMENTS = ["테스트 댓글", "테스트다", "test"];

  Widget _header(String? nickname) {
    return Padding(
      padding: EdgeInsets.all(CommonSize.paddingMd),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: CommonSize.paddingMd, right: CommonSize.paddingMd),
            child: StoryAvatarWidget(
                size: CommonSize.avatar3xl, imagePath: _MOCK_IMAGE_URL),
          ),
          if (nickname != null)
            Text(
              nickname,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: CommonSize.fontsizeLg),
            ),
          Expanded(child: SizedBox()),
          Padding(
            padding: EdgeInsets.all(CommonSize.paddingMd),
            child: ImageIconWidget(
              imagePath: ImagePath.postMoreIcon,
              size: CommonSize.avatar3xl,
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
      padding: EdgeInsets.symmetric(horizontal: CommonSize.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              ImageIconWidget(
                imagePath: ImagePath.likeOffIcon,
                size: CommonSize.iconSizeLg,
              ),
              SizedBox(
                width: CommonSize.paddingMd,
              ),
              ImageIconWidget(
                imagePath: ImagePath.replyIcon,
                size: CommonSize.iconSizeLg,
              ),
              SizedBox(
                width: CommonSize.paddingMd,
              ),
              ImageIconWidget(
                imagePath: ImagePath.directMessage,
                size: CommonSize.iconSizeLg,
              ),
              const Expanded(child: SizedBox()),
              ImageIconWidget(imagePath: ImagePath.bookMarkOffIcon),
            ],
          ),
          SizedBox(
            height: CommonSize.paddingMd,
          ),
          Text(
            "좋아요 40개",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: CommonSize.fontsizeMd),
          )
        ],
      ),
    );
  }

  Widget _comments() {
    return Padding(
      padding: EdgeInsets.all(CommonSize.paddingMd),
      child: Column(
        children: [
          ..._MOCK_COMMENTS.map((e) => Row(
                children: [
                  // TODO : 닉네임/댓글 정보 박기
                  Text(
                    'Karma',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: CommonSize.paddingMd,
                  ),
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
                  padding: EdgeInsets.only(top: CommonSize.paddingLg),
                  child: Column(
                    children: [
                      _header(_MOCK_NICKNAME),
                      SizedBox(
                        height: CommonSize.paddingMd,
                      ),
                      _postBody(_MOCK_IMAGE_URL),
                      SizedBox(
                        height: CommonSize.paddingLg,
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
