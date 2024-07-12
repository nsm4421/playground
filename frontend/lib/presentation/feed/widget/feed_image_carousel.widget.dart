import 'package:flutter/material.dart';

class FeedImageCarouselWidget extends StatefulWidget {
  const FeedImageCarouselWidget(this.images, {super.key});

  // 피드 이미지 public url 목록
  final List<String> images;

  @override
  State<FeedImageCarouselWidget> createState() =>
      _FeedImageCarouselWidgetState();
}

class _FeedImageCarouselWidgetState extends State<FeedImageCarouselWidget> {
  late PageController _pageController;

  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round() + 1;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Stack(children: [
          // Carousel
          PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              itemBuilder: (_, index) {
                return Image.network(widget.images[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext _, Widget child,
                            ImageChunkEvent? loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : Center(
                                child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              )));
              }),
          // 페이지 번호
          Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  child: Text("$_currentPage/${widget.images.length}",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer)))),
        ]),
      );
}
