part of "display_feed.page.dart";

class DisplayMediaWidget extends StatefulWidget {
  const DisplayMediaWidget(this._media,
      {super.key, this.size = 400, this.borderRadius = 15});

  final List<String> _media;
  final double size;
  final double borderRadius;

  @override
  State<DisplayMediaWidget> createState() => _DisplayMediaWidgetState();
}

class _DisplayMediaWidgetState extends State<DisplayMediaWidget> {
  late PageController _controller;
  int _currentPage = 0;

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

  _handleIndex(int index) => () {
        _controller.animateToPage(index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        setState(() {
          _currentPage = index;
        });
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: PageView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: widget._media.length,
              itemBuilder: (context, index) {
                return Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            widget._media[index],
                          ))),
                );
              }),
        ),
        if (widget._media.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget._media.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                      onTap: _handleIndex(index),
                      child: _currentPage == index
                          ? Icon(Icons.circle_rounded,
                              size: 12,
                              color: Theme.of(context).colorScheme.primary)
                          : const Icon(Icons.circle_outlined, size: 12)),
                );
              }),
            ),
          )
      ],
    );
  }
}
