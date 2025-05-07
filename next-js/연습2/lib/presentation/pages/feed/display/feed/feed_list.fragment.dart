part of "display_feed.page.dart";

class FeedListFragment extends StatelessWidget {
  const FeedListFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayFeedBloc, DisplayFeedState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.success:
            final feeds = context.read<DisplayFeedBloc>().state.data;
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: feeds.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: FeedItemWidget(feeds[index]),
                    ));
          case Status.initial:
          case Status.loading:
          case Status.error:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
