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
    _stream = context.read<FeedBloc>().feedStream;
  }

  _handleGoToUploadPage(){
    context.push(Routes.uploadFeed.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FEED"),
        actions: [
          IconButton(onPressed: _handleGoToUploadPage, icon: const Icon(Icons.add))
        ],
      ),
      body: BlocListener<FeedBloc, FeedState>(
          listenWhen: (previous, current) {
            return (current is FetchFeedSuccessState);
          },
          listener: (context, state) {
            if (state is FetchFeedSuccessState) {
              _feeds.addAll(state.feeds);
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
