part of 'page.dart';

class DisplayMeetingScreen extends StatefulWidget {
  const DisplayMeetingScreen({super.key});

  @override
  State<DisplayMeetingScreen> createState() => _DisplayMeetingScreenState();
}

class _DisplayMeetingScreenState extends State<DisplayMeetingScreen> {
  double _previousPosition = 0;
  bool _showAppBar = true;
  bool _isOptionEmpty = true;
  late ScrollController _scrollController;

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

  void _handleScroll() {
    final currentPosition = _scrollController.position.pixels;
    // 스크롤이 내려갈 때 앱바가 안 보이고, 올라갈 때 앱바가 보임
    setState(() {
      _showAppBar = _previousPosition > currentPosition;
      _previousPosition = currentPosition;
    });
  }

  Future<void> _handleRefresh() async {
    context.read<DisplayMeetingBloc>().add(FetchEvent(refresh: true));
  }

  _handleMoveToCreateMeetingPage() {
    context.push(Routes.createMeeting.path);
  }

  _handleShowOptionModal() async {
    context.read<HomeBottomNavCubit>().handleVisible(false);
    await showModalBottomSheet<MeetingSearchOption>(
        context: context,
        showDragHandle: true,
        builder: (_) {
          return OptionModalModal(context.read<DisplayMeetingBloc>().option);
        }).then((res) {
      if (res != null) {
        context.read<DisplayMeetingBloc>().add(SearchMeetingEvent(option: res));
        setState(() {
          _isOptionEmpty = res.isEmpty;
        });
      }
      context.read<HomeBottomNavCubit>().handleVisible(true);
    });
  }

  _handleInitFilter() {
    context.read<DisplayMeetingBloc>().add(MeetingFilterOffEvent());
    setState(() {
      _isOptionEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar
          ? AppBar(title: const Text('Meeting'), actions: [
              IconButton(
                  tooltip: '게시글 작성하기',
                  onPressed: _handleMoveToCreateMeetingPage,
                  icon: const Icon(Icons.add_box_outlined)),
              IconButton(
                  onPressed: _handleShowOptionModal,
                  icon: const Icon(Icons.search))
            ])
          : null,
      body: Scaffold(
          body: RefreshIndicator(
              onRefresh: _handleRefresh, child: const MeetingItemsFragment())),
      floatingActionButton: _isOptionEmpty
          ? null
          : FloatingActionButton.small(
              onPressed: _handleInitFilter,
              child: const Icon(Icons.filter_alt_off_outlined),
            ),
    );
  }
}
