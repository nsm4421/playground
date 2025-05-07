part of 'index.dart';

class SearchedFragment extends StatefulWidget {
  const SearchedFragment({super.key});

  @override
  State<SearchedFragment> createState() => _SearchedFragmentState();
}

class _SearchedFragmentState extends State<SearchedFragment> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_handleScroll)
      ..dispose();
  }

  _handleScroll() {
    if (_controller.position.extentAfter < 20 &&
        !context.read<SearchFeedBloc>().state.isEnd &&
        context.read<SearchFeedBloc>().state.status != Status.loading) {
      context
          .read<SearchFeedBloc>()
          .add(FetchEvent<FeedEntity, SearchFeedOption>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFeedBloc,
        CustomSearchState<FeedEntity, SearchFeedOption>>(
      builder: (context, state) {
        return GridView.builder(
          controller: _controller,
          itemCount: state.data.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = state.data[index];
            return CachedSquareImageWidget(
              item.images.first,
              borderRound: 12,
            );
          },
        );
      },
    );
  }
}
