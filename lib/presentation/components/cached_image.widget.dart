part of 'export.components.dart';

class CustomCachedImageWidget extends StatelessWidget {
  const CustomCachedImageWidget(this._url,
      {super.key, this.width, this.height, this.fit});

  final String _url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final $url = '${ApiEndPoint.domain}$_url';
    return CachedNetworkImage(
      imageUrl: $url,
      imageBuilder: (context, imageProvider) => Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
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
