import 'package:flutter/material.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';

class FeedItemWidget extends StatelessWidget {
  const FeedItemWidget(this.feed, {super.key});

  final FeedModel feed;

  static const double _borderRadius = 30;
  static const double _horizontalPaddingSize = 15;
  static const double _verticalPaddingSize = 10;
  static const double _elevation = 10;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
            horizontal: _horizontalPaddingSize, vertical: _verticalPaddingSize),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadius)),
          elevation: _elevation,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              child: Text(feed.toString()),
            ),
          ),
        ),
      );
}
