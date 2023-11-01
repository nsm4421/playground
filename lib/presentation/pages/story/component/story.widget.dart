import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/domain/model/story/story.model.dart';

class StoryViewWidget extends StatefulWidget {
  const StoryViewWidget(this.story, {super.key});

  final StoryModel story;

  static const double _iconSize = 40;
  static const double _verticalOffset = 60;
  static const double _horizontalOffset = 30;

  @override
  State<StoryViewWidget> createState() => _StoryViewWidgetState();
}

class _StoryViewWidgetState extends State<StoryViewWidget> {
  bool _showOnlyImage = false;
  int _currentImageIndex = 0;

  _handleShowMetaData() {
    setState(() {
      _showOnlyImage = !_showOnlyImage;
    });
  }

  _handleTapLeftScreen() {
    if (_currentImageIndex <= 0) return;
    setState(() {
      _currentImageIndex -= 1;
    });
  }

  _handleTapRightScreen() {
    if (_currentImageIndex >= widget.story.imageUrls.length - 1) return;
    setState(() {
      _currentImageIndex += 1;
    });
  }

  // TODO : 이벤트 기능 구현
  _handleClickLikeButton() {}

  _handleClickCommentButton() {}

  _handleClickMoreButton() {}

  @override
  Widget build(BuildContext context) => GestureDetector(
        onDoubleTap: _handleShowMetaData,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height:
              MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
          child: Stack(
            children: [
              // 이미지
              Positioned.fill(
                child: Image.network(
                  widget.story.imageUrls[_currentImageIndex],
                  fit: BoxFit.cover,
                ),
              ),
              // 검은 바탕
              if (!_showOnlyImage)
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              // 좌우 영역
              if (!_showOnlyImage)
                Positioned(
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: _handleTapLeftScreen,
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2)),
                      GestureDetector(
                          onTap: _handleTapRightScreen,
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2)),
                    ],
                  ),
                ),
              // 닉네임
              if (!_showOnlyImage)
                Positioned(
                  bottom: StoryViewWidget._horizontalOffset +
                      StoryViewWidget._verticalOffset,
                  left: StoryViewWidget._horizontalOffset,
                  child: Row(
                    children: [
                      const CircleAvatar(),
                      const SizedBox(width: 10),
                      Text(
                        widget.story.user?.nickname ?? 'Error',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              // 설명
              if (!_showOnlyImage)
                Positioned(
                  bottom: StoryViewWidget._horizontalOffset,
                  left: StoryViewWidget._horizontalOffset,
                  child: Text(
                    widget.story.content ?? 'Error',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              // 좋아요 버튼
              if (!_showOnlyImage)
                Positioned(
                  bottom: StoryViewWidget._horizontalOffset +
                      2 * StoryViewWidget._verticalOffset,
                  right: StoryViewWidget._horizontalOffset,
                  child: IconButton(
                      onPressed: _handleClickLikeButton,
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: StoryViewWidget._iconSize,
                      )),
                ),
              // 댓글 버튼
              if (!_showOnlyImage)
                Positioned(
                  bottom: StoryViewWidget._horizontalOffset +
                      StoryViewWidget._verticalOffset,
                  right: StoryViewWidget._horizontalOffset,
                  child: IconButton(
                      onPressed: _handleClickCommentButton,
                      icon: const Icon(Icons.chat,
                          color: Colors.white,
                          size: StoryViewWidget._iconSize)),
                ),
              // 더보기 버튼
              if (!_showOnlyImage)
                Positioned(
                  bottom: StoryViewWidget._horizontalOffset,
                  right: StoryViewWidget._horizontalOffset,
                  child: IconButton(
                      onPressed: _handleClickMoreButton,
                      icon: const Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.white,
                        size: StoryViewWidget._iconSize,
                      )),
                ),
              // 검은색
            ],
          ),
        ),
      );
}
