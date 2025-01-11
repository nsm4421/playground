part of 'export.components.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget(this._urls, {super.key, this.maxHeight});

  final List<String> _urls;
  final double? maxHeight;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: widget.maxHeight ?? MediaQuery.of(context).size.width),
          child: PageView.builder(
            controller: _controller,
            itemCount: widget._urls.length,
            itemBuilder: (context, index) =>
                CustomCachedImageWidget(widget._urls[index]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SmoothPageIndicator(
              controller: _controller,
              count: widget._urls.length,
              effect: WormEffect(
                  dotWidth: 12,
                  dotHeight: 12,
                  activeDotColor: context.colorScheme.secondary,
                  dotColor: context.colorScheme.secondary.withOpacity(0.5)),
              onDotClicked: (int index) async {
                await _controller.animateToPage(index,
                    duration: 300.ms, curve: Curves.easeInSine);
              }),
        )
      ],
    );
  }
}
