part of 'feed.page.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<FeedEntity> _feeds = [];
  late Stream<List<FeedEntity>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = context.read<DisplayFeedBloc>().feedStream;
  }

  _handleGoToUploadPage() {
    context.push(Routes.uploadFeed.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FEED"),
        actions: [
          IconButton(
              onPressed: _handleGoToUploadPage, icon: const Icon(Icons.add))
        ],
      ),
      body: BlocListener<DisplayFeedBloc, DisplayFeedState>(
          listenWhen: (previous, current) {
            return (current is DisplayFeedSuccessState);
          },
          listener: (context, state) {
            if (state is DisplayFeedSuccessState) {
              _feeds.addAll(state.feeds);
              context.read<DisplayFeedBloc>().add(InitDisplayFeedEvent());
            }
          },
          child: StreamBuilderWidget<List<FeedEntity>>(
              initData: _feeds,
              stream: _stream,
              onSuccessWidgetBuilder: (List<FeedEntity> data) {
                print(data);
                return FeedListFragment([...data, ..._feeds]);
              })),
    );
  }
}
