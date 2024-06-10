import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(this._profileUrl, {super.key, this.radius = 20});

  final String _profileUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2 * radius,
      height: 2 * radius,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: _profileUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        imageBuilder: (context, imageProvider) =>
            CircleAvatar(backgroundImage: imageProvider),
      ),
    );
  }
}
