import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/presentation/pages/feed/component/feed_item_content.widget.dart';
import 'package:my_app/presentation/pages/feed/component/feed_item_header.widget.dart';
import 'package:my_app/presentation/pages/feed/component/feed_item_icon_buttons.widget.dart';

class FeedItemWidgetWithImageWidget extends StatefulWidget {
  const FeedItemWidgetWithImageWidget(this.feed, {super.key});

  final FeedModel feed;

  @override
  State<FeedItemWidgetWithImageWidget> createState() =>
      _FeedItemWidgetWithImageWidgetState();
}

class _FeedItemWidgetWithImageWidgetState
    extends State<FeedItemWidgetWithImageWidget> {
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FeedItemHeader(widget.feed.uid!),
          if (widget.feed.images.isNotEmpty)
            _CarouselSliderWidget(
                images: widget.feed.images, controller: _carouselController),
          const FeedItemIconButtonsWidget(),
          FeedItemContentWidget(
              content: widget.feed.content ?? '',
              hashtags: widget.feed.hashtags)
        ],
      );
}

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
