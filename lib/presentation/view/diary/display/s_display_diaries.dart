part of 'page.dart';

class DisplayDiariesScreen extends StatefulWidget {
  const DisplayDiariesScreen({super.key});

  @override
  State<DisplayDiariesScreen> createState() => _DisplayDiariesScreenState();
}

class _DisplayDiariesScreenState extends State<DisplayDiariesScreen> {
  late ScrollController _scrollController;
  double _previousPosition = 0;
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
  }

  Future<void> _handleRefresh() async {
    context.read<DisplayDiaryBloc>().add(FetchEvent(refresh: true));
  }

  void _handleScroll() {
    final currentPosition = _scrollController.position.pixels;
    // 스크롤이 내려갈 때 앱바가 안 보이고, 올라갈 때 앱바가 보임
    setState(() {
      _showAppBar = currentPosition < _previousPosition;
      _previousPosition = currentPosition;
    });
    // 스크롤이 맨 아래에서 30px만큼 떨어진 곳까지 오면, 추가로 Fetching
    if (currentPosition >= _scrollController.position.maxScrollExtent - 30) {
      context.read<DisplayDiaryBloc>().add(FetchEvent<DiaryEntity>());
    }
  }

  // TODO : 필터링 기능 구현하기
  _handleShowFilter() {}

  _handleShowFilterOff() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayDiaryBloc, CustomDisplayState<DiaryEntity>>(
        builder: (context, state) {
      return LoadingOverLayScreen(
          isLoading: state.status == Status.loading,
          loadingWidget: const Center(child: CircularProgressIndicator()),
          childWidget: Scaffold(
              appBar: _showAppBar
                  ? AppBar(title: const Text('여행일기'), elevation: 0, actions: [
                      // 메타 데이터 입력 페이지로 이동 버튼
                      IconButton(
                          onPressed: _handleShowFilter,
                          icon: const Icon(Icons.filter_list_outlined),
                          tooltip: '필터'),
                      // 메타 데이터 입력 페이지로 이동 버튼
                      IconButton(
                          onPressed: _handleShowFilterOff,
                          icon: const Icon(Icons.filter_alt_off_outlined),
                          tooltip: '필터 해제')
                    ])
                  : null,
              body: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: ListView.separated(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return DiaryItemWidget(state.data[index]);
                      },
                      separatorBuilder: (context, index) {
                        if (index < state.data.length - 1) {
                          return const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              child: Divider());
                        } else if (state.isEnd) {
                          return const SizedBox();
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }))));
    });
  }
}
