part of 'export.components.dart';

class CustomCachedImageWidget extends StatelessWidget {
  const CustomCachedImageWidget(this._url,
      {super.key, this.width, this.height, this.fit, this.boxShape});

  final String _url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BoxShape? boxShape;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _url,
      imageBuilder: (context, imageProvider) => Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          shape: boxShape ?? BoxShape.rectangle,
          image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.grey, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) {
        log(error.toString());
        return const Icon(Icons.error);
      },
    );
  }
}

class CustomCircleAvatarWidget extends StatelessWidget {
  const CustomCircleAvatarWidget(this._url,
      {super.key, this.radius = 30, this.fit});

  final String _url;
  final double radius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 2 * radius, maxHeight: 2 * radius),
      child: CustomCachedImageWidget(
        _url,
        fit: fit ?? BoxFit.cover,
        boxShape: BoxShape.circle,
      ),
    );
  }
}
