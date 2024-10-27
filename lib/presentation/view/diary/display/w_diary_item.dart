part of 'page.dart';

class DiaryItemWidget extends StatefulWidget {
  const DiaryItemWidget(this._diary, {super.key});

  final DiaryEntity _diary;

  @override
  State<DiaryItemWidget> createState() => _DiaryItemWidgetState();
}

class _DiaryItemWidgetState extends State<DiaryItemWidget> {
  static const double _indicatorSize = 12;

  late PageController _pageController;
  late List<bool> _isBlurList;
  int _currentPage = 0;

  int get _length => widget._diary.images.length;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _isBlurList = widget._diary.images.map((item) => item == null).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  _handleJumpPage(int page) {
    if (_currentPage != page) {
      _pageController.animateToPage(page,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  _handleSwitchIsBlurred(int index) {
    log('_handleSwitchIsBlurred called index:$index');
    setState(() {
      _isBlurList[index] = !_isBlurList[index];
    });
  }

  _handleShowDetail() async {
    await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) => DiaryDetailScreen(widget._diary));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// header
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 프로필 이미지
                        if (widget._diary.author?.avatarUrl != null)
                          CircularAvatarWidget(widget._diary.author!.avatarUrl),
                        const SizedBox(width: 12),
                        // 유저명
                        Text(widget._diary.author?.username ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w500))
                      ])),

              /// images
              if (_length != 0)
                GestureDetector(
                    onDoubleTap: _handleShowDetail,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: _onPageChanged,
                            scrollDirection: Axis.horizontal,
                            itemCount: _length,
                            itemBuilder: (context, index) {
                              final image = widget._diary.images[index];
                              final caption = widget._diary.captions[index];
                              final isBlur = _isBlurList[index];
                              return GestureDetector(
                                onTap: () {
                                  if (caption != null) {
                                    _handleSwitchIsBlurred(index);
                                  }
                                },
                                child: Stack(children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          image: image != null
                                              ? DecorationImage(
                                                  fit: BoxFit.fitHeight,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          image))
                                              : null)),
                                  if (isBlur)
                                    BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                            color:
                                                Colors.black.withOpacity(0))),
                                  if (caption != null && isBlur)
                                    Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4)),
                                        child: Center(
                                            child: Text(
                                                widget._diary.captions[index]!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                        color: Colors.white),
                                                softWrap: true,
                                                overflow:
                                                    TextOverflow.ellipsis))),
                                ]),
                              );
                            }))),

              /// indicator
              if (_length > 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_length, (index) {
                      final isSelected = index == _currentPage;
                      return GestureDetector(
                        onTap: () {
                          _handleJumpPage(index);
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: _indicatorSize,
                            height: _indicatorSize,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent)),
                      );
                    }),
                  ),
                ),

              /// 본문
              if (widget._diary.content != null)
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: ExpandableTextWidget(widget._diary.content!)),

              /// 아이콘 위젯
              IconsWidget(widget._diary)
            ]));
  }
}
