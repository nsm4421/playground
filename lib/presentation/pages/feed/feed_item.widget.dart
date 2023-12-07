import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/presentation/pages/feed/component/feed_item_icon_buttons.widget.dart';

/// Feed Item
class FeedItemWidget extends StatelessWidget {
  const FeedItemWidget(this.feed, {super.key});

  final FeedModel feed;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 8),
          feed.images.isEmpty
              ? _FeedItemWidgetWithoutImage(feed)
              : _FeedItemWidgetWithImageWidget(feed),
          const SizedBox(height: 8),
          Divider(thickness: 1, color: Colors.blueGrey.withOpacity(0.5))
        ],
      );
}

/// Feed Item(with image) - 이미지가 업로드 된 피드의 경우 이미지 Slider로 보여줌
class _FeedItemWidgetWithImageWidget extends StatefulWidget {
  const _FeedItemWidgetWithImageWidget(this.feed, {super.key});

  final FeedModel feed;

  @override
  State<_FeedItemWidgetWithImageWidget> createState() =>
      _FeedItemWidgetWithImageWidgetState();
}

class _FeedItemWidgetWithImageWidgetState
    extends State<_FeedItemWidgetWithImageWidget> {
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _FeedItemHeader(widget.feed.uid!),
          if (widget.feed.images.isNotEmpty)
            _CarouselSliderWidget(
                images: widget.feed.images, controller: _carouselController),
          FeedItemIconButtonsWidget(widget.feed.feedId!),
          _FeedItemContentWidget(
              content: widget.feed.content ?? '',
              hashtags: widget.feed.hashtags)
        ],
      );
}

/// Feed Item(without image)
class _FeedItemWidgetWithoutImage extends StatefulWidget {
  const _FeedItemWidgetWithoutImage(this.feed, {super.key});

  final FeedModel feed;

  @override
  State<_FeedItemWidgetWithoutImage> createState() =>
      _FeedItemWidgetWithImageState();
}

class _FeedItemWidgetWithImageState extends State<_FeedItemWidgetWithoutImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _FeedItemHeader(widget.feed.uid!),
          _FeedItemContentWidget(
              content: widget.feed.content ?? '',
              hashtags: widget.feed.hashtags),
          FeedItemIconButtonsWidget(widget.feed.feedId!)
        ],
      );
}

/// Header
class _FeedItemHeader extends StatelessWidget {
  const _FeedItemHeader(this.uid, {super.key});

  final String uid;

  // TODO : 더보기 버튼 이벤트 등록
  void _handleClickMoreButton() {}

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const SizedBox(width: 15),
          // TODO : 실제 유저의 프로필 사진 보여주기
          const CircleAvatar(),
          const SizedBox(width: 5),
          // TODO : 실제 유저의 닉네임 보여주기
          Text(uid,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          IconButton(
              onPressed: _handleClickMoreButton,
              icon: const Icon(Icons.more_vert, color: Colors.grey)),
          const SizedBox(width: 15)
        ],
      );
}

/// 본문, 해시태그
class _FeedItemContentWidget extends StatelessWidget {
  const _FeedItemContentWidget(
      {super.key, required this.content, required this.hashtags});

  final String content;
  final List<String> hashtags;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              if (hashtags.isNotEmpty)
                Row(
                  children: hashtags
                      .map((hashtag) => Row(
                            children: [
                              Text("#$hashtag",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent)),
                              const SizedBox(width: 8)
                            ],
                          ))
                      .toList(),
                )
            ],
          ),
          const SizedBox(width: 15),
        ],
      );
}

/// 이미지 Slider
class _CarouselSliderWidget extends StatelessWidget {
  const _CarouselSliderWidget(
      {super.key, required this.images, required this.controller});

  final List<String> images;
  final CarouselController controller;

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
          items: images
              .map((url) => Image.network(url,
                  width: MediaQuery.of(context).size.width, fit: BoxFit.cover))
              .toList(),
          options: CarouselOptions(
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
          ),
        ),
      );
}
