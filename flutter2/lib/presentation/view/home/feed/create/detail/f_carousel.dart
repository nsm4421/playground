part of '../index.dart';

class CarouselFragment extends StatefulWidget {
  const CarouselFragment({super.key});

  @override
  State<CarouselFragment> createState() => _CarouselFragmentState();
}

class _CarouselFragmentState extends State<CarouselFragment> {
  late PageController _controller;
  int _currentPage = 1;

  @override
  initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  dispose() async {
    super.dispose();
    _controller.dispose();
  }

  _handleClickDot(int index) async {
    await _controller.animateToPage(index,
        duration: 200.ms, curve: Curves.easeIn);
  }

  _handlePageChanged(int index) {
    setState(() {
      _currentPage = index + 1;
    });
  }

  _handleNavigateEditCaptionPage(int index) => () async {
        await showModalBottomSheet(
            context: context,
            builder: (_) {
              return EditCaptionFragment(
                  context.read<CreateFeedBloc>().state.captions[index]);
            }).then(
          (res) {
            if (res != null) {
              context
                  .read<CreateFeedBloc>()
                  .add(EditCaptionEvent(caption: res, index: index));
            }
          },
        );
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: context.width,
                  height: context.width,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: state.images.length,
                    onPageChanged: _handlePageChanged,
                    itemBuilder: (context, index) {
                      final asset = state.images[index];
                      final caption = state.captions[index];
                      return GestureDetector(
                        onTap: _handleNavigateEditCaptionPage(index),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetEntityImageProvider(asset),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            if (caption.isNotEmpty)
                              Align(
                                child: Text(
                                  caption,
                                  softWrap: true,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    color: CustomPalette.white,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      const Shadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 4.0,
                                          color: CustomPalette.mediumGrey)
                                    ],
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                    color: CustomPalette.darkGrey,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Text(
                                  '$_currentPage/${state.images.length}',
                                  style: context.textTheme.bodyMedium
                                      ?.copyWith(color: CustomPalette.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            if (state.images.length > 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: state.images.length,
                    onDotClicked: _handleClickDot,
                    effect: SlideEffect(
                        spacing: 8,
                        dotWidth: 12,
                        dotHeight: 13,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: CustomPalette.lightGrey,
                        activeDotColor: context.colorScheme.primary),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
