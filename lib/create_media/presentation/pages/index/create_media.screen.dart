part of 'create_media.page.dart';

class CreateMediaScreen extends StatefulWidget {
  const CreateMediaScreen({super.key});

  @override
  State<CreateMediaScreen> createState() => _CreateMediaScreenState();
}

class _CreateMediaScreenState extends State<CreateMediaScreen> {
  static const double _floatingButtonWidth = 160;
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _pageController.jumpToPage(index);
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
      PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [CreateFeedPage(), CreateReelsPage()],
      ),

      // floating 버튼
      AnimatedPositioned(
          duration: const Duration(milliseconds: 350),
          bottom: CustomSpacing.lg,
          left: _currentIndex == 0
              ? MediaQuery.of(context).size.width / 2 - _floatingButtonWidth / 3
              : MediaQuery.of(context).size.width / 2 -
                  _floatingButtonWidth / 1.5,
          child: Container(
              width: _floatingButtonWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSpacing.sm, vertical: CustomSpacing.tiny),
              decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                  borderRadius: BorderRadius.circular(CustomSpacing.md)),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _onPageChanged(0);
                        },
                        child: Text("Feed",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(
                                                _currentIndex == 0 ? 1 : 0.5),
                                    fontWeight: _currentIndex == 0
                                        ? FontWeight.bold
                                        : FontWeight.normal))),
                    CustomWidth.md,
                    GestureDetector(
                        onTap: () {
                          _onPageChanged(1);
                        },
                        child: Text("Reels",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(
                                                _currentIndex == 1 ? 1 : 0.5),
                                    fontWeight: _currentIndex == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal)))
                  ])))
    ]));
  }
}
