import 'package:chat_app/model/feed_model.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:flutter/material.dart';

enum Emotion {
  LIKE,
  DISLIKE,
  NONE;
}

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget({super.key, required this.feedModel});

  final FeedModel feedModel;

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  Emotion _emotion = Emotion.NONE;

  // TODO
  _handleClickLike() {}

  _handleClickDisLike() {}

  // TODO : 유저 프로필 이미지, 닉네임 가져오기
  Widget _header() => Row(
        children: [
          const CircleAvatar(),
          const Width(10),
          Text(
            widget.feedModel.author ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      );

  Widget _postImage() => (widget.feedModel.image != null)
      ? SizedBox(
          child: Image.network(
            fit: BoxFit.cover,
            widget.feedModel.image!,
          ),
        )
      : const SizedBox();

  Widget _postContent() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Text(
          widget.feedModel.content ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      );

  Widget _postIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.thumb_up,
                    color:
                        (_emotion == Emotion.LIKE) ? Colors.red : Colors.grey,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.thumb_down,
                    color: (_emotion == Emotion.DISLIKE)
                        ? Colors.blue
                        : Colors.grey,
                  )),
              const Expanded(child: SizedBox()),
              IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          const Height(20),
          _postImage(),
          const Height(20),
          _postContent(),
          const Height(30),
          _postIcons(),
        ],
      ),
    );
  }
}
