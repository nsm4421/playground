import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CircularAvatarImageWidget extends StatelessWidget {
  const CircularAvatarImageWidget(this.imageUrl, {super.key, this.radius = 40});

  final String imageUrl;

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      onBackgroundImageError: (exception, stackTrace) {
        log(stackTrace.toString());
      },
    );
  }
}
