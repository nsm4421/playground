part of 'page.dart';

class DisplayMeetingScreen extends StatefulWidget {
  const DisplayMeetingScreen({super.key});

  @override
  State<DisplayMeetingScreen> createState() => _DisplayMeetingScreenState();
}

class _DisplayMeetingScreenState extends State<DisplayMeetingScreen> {
  static const double _searchWidgetHeight = 80;
  bool _isAppBarVisible = true;
  bool _isExpanded = true;
  double _previousPosition = 0;
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
      _isAppBarVisible = currentPosition < _previousPosition;
      _previousPosition = currentPosition;
    });
  }

  Future<void> _handleRefresh() async {
    context.read<DisplayMeetingBloc>().add(FetchEvent(refresh: true));
  }

  _handleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _isAppBarVisible
            ? AppBar(title: const Text('Meeting'), actions: [
                IconButton(
                    onPressed: _handleExpand,
                    icon: _isExpanded
                        ? const Icon(Icons.expand_less)
                        : const Icon(Icons.expand_more))
              ])
            : null,
        body: Scaffold(
            body: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Stack(children: [
                      Padding(
                          padding: EdgeInsets.only(
                              top: _isExpanded ? _searchWidgetHeight : 0),
                          child: const MeetingItemsFragment()),
                      if (_isAppBarVisible && _isExpanded)
                        const Positioned(
                            top: 0,
                            child: SizedBox(
                                height: _searchWidgetHeight,
                                child: SearchFragment()))
                    ])))));
  }
}
