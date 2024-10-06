part of '../index.page.dart';

class EditorBody extends StatefulWidget {
  const EditorBody({super.key});

  @override
  State<EditorBody> createState() => _EditorBodyState();
}

class _EditorBodyState extends State<EditorBody> {
  late PageController _pageController;

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

  _handleMovePage(int page) {
    context.read<EditDiaryBloc>().add(MovePageEvent(page));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditDiaryBloc, EditDiaryState>(
        // current index가 변경되는 경우 페이지 페이지 전환
        listenWhen: (prev, curr) =>
            (prev.currentIndex != curr.currentIndex) ||
            (curr.currentIndex != _pageController.page?.round()),
        listener: (context, state) {
          _pageController.animateToPage(state.currentIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        },
        child: BlocBuilder<EditDiaryBloc, EditDiaryState>(
          builder: (context, state) {
            return PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: state.totalPage,
                onPageChanged: _handleMovePage,
                itemBuilder: (context, index) {
                  final page = state.pages[index];
                  return EditorPageItemWidget(page);
                });
          },
        ));
  }
}
