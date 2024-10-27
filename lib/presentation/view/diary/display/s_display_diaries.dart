part of 'page.dart';

class DisplayDiariesScreen extends StatefulWidget {
  const DisplayDiariesScreen({super.key});

  @override
  State<DisplayDiariesScreen> createState() => _DisplayDiariesScreenState();
}

class _DisplayDiariesScreenState extends State<DisplayDiariesScreen> {
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

  Future<void> _handleRefresh() async {
    context.read<DisplayDiaryBloc>().add(FetchEvent(refresh: true));
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 30) {
      context.read<DisplayDiaryBloc>().add(FetchEvent<DiaryEntity>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayDiaryBloc, CustomDisplayState<DiaryEntity>>(
        builder: (context, state) {
      return LoadingOverLayScreen(
          isLoading: state.status == Status.loading,
          loadingWidget: const Center(child: CircularProgressIndicator()),
          childWidget: Scaffold(
              appBar: const DisplayDiaryAppBarWidget(),
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
