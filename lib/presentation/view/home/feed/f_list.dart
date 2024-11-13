part of 'index.dart';

class FeedListFragment extends StatelessWidget {
  const FeedListFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayFeedBloc, CustomDisplayState<FeedEntity>>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<DisplayFeedBloc>().add(FetchEvent(refresh: true));
          },
          child: ListView.separated(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return FeedItemWidget(state.data[index]);
            },
            separatorBuilder: (context, index) {
              return (index == state.data.length) && !state.isEnd
                  ? const Center(child: CircularProgressIndicator())
                  : const Divider(indent: 30, endIndent: 30);
            },
          ),
        );
      },
    );
  }
}
