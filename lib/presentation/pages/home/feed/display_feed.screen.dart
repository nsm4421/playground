part of '../../export.pages.dart';

class DisplayFeedScreen extends StatelessWidget {
  const DisplayFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DisplayFeedBloc>().add(MountEvent());
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Display Feed"),
            actions: [
              IconButton(
                  onPressed: () {
                    context.push(Routes.createFeed.path);
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          body: BlocBuilder<DisplayFeedBloc, DisplayState<FeedEntity>>(
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: context.read<DisplayFeedBloc>().state.data.length,
                itemBuilder: (context, index) {
                  final item =
                      context.read<DisplayFeedBloc>().state.data[index];
                  return FeedItemWidget(item);
                },
                separatorBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    child: Divider()),
              );
            },
          )),
    );
  }
}
