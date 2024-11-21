part of '../widget.dart';

class CachedCircularImageWidget extends StatelessWidget {
  const CachedCircularImageWidget(this.imageUrl, {super.key, this.radius});

  final String imageUrl;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return _CachedImageBuilder(
      imageUrl: imageUrl,
      imageBuilder: (context, provider) => CircleAvatar(
        backgroundImage: provider,
        radius: radius,
      ),
    );
  }
}

class CachedSquareImageWidget extends StatelessWidget {
  const CachedSquareImageWidget(this.imageUrl,
      {super.key, this.width, this.height, this.boxFit});

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return _CachedImageBuilder(
      imageUrl: imageUrl,
      boxFit: boxFit,
      imageBuilder: (context, provider) => Container(
        width: width ?? context.width,
        height: height ?? context.width,
        decoration: BoxDecoration(
          color: context.colorScheme.tertiary,
          image: DecorationImage(
            fit: boxFit ?? BoxFit.cover,
            image: provider,
          ),
        ),
      ),
    );
  }
}

class _CachedImageBuilder extends StatelessWidget {
  const _CachedImageBuilder(
      {super.key,
      required this.imageUrl,
      required this.imageBuilder,
      this.boxFit});

  final String imageUrl;
  final BoxFit? boxFit;
  final Widget Function(BuildContext, ImageProvider<Object>) imageBuilder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: context.colorScheme.secondary,
        highlightColor: context.colorScheme.tertiary,
        child: const Icon(Icons.rotate_left),
      ),
      errorWidget: (context, url, error) {
        log('[ERROR]${error.toString()}');
        return Shimmer.fromColors(
          baseColor: CustomPalette.error,
          highlightColor: context.colorScheme.tertiary,
          child: const Icon(Icons.error_outline),
        );
      },
      fit: boxFit ?? BoxFit.contain,
      imageUrl: imageUrl,
      imageBuilder: imageBuilder,
    );
  }
}
