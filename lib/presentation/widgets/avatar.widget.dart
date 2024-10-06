part of 'widgets.dart';

class CircularAvatarWidget extends StatelessWidget {
  const CircularAvatarWidget(this.avatarUrl,
      {super.key, this.fit = BoxFit.cover, this.size = 60});

  final String avatarUrl;
  final double size;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: fit, image: CachedNetworkImageProvider(avatarUrl))));
  }
}

class RoundedAvatarWidget extends StatelessWidget {
  const RoundedAvatarWidget(this.avatarUrl,
      {super.key,
      this.fit = BoxFit.fitHeight,
      this.borderRadius = 12,
      this.width = 60,
      this.height = 60});

  final String avatarUrl;
  final double width;
  final double height;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Theme.of(context).colorScheme.tertiaryContainer,
            image: DecorationImage(
                fit: fit, image: CachedNetworkImageProvider(avatarUrl))));
  }
}
