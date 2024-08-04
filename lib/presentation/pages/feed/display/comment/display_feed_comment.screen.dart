part of "display_feed_comment.page.dart";

class DisplayFeedCommentScreen extends StatefulWidget {
  const DisplayFeedCommentScreen({super.key});

  @override
  State<DisplayFeedCommentScreen> createState() =>
      _DisplayFeedCommentScreenState();
}

class _DisplayFeedCommentScreenState extends State<DisplayFeedCommentScreen> {
  _handlePop() {
    if (context.mounted) {
      context.pop();
    }
  }

  _handleShowModal() async {
    log('show modal');
    final feedId = context.read<DisplayFeedCommentBloc>().feeId;
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: CreateFeedCommentPage(feedId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Comment"),
          leading:
              IconButton(onPressed: _handlePop, icon: const Icon(Icons.clear))),
      body: Stack(
        children: [
          const Column(
            children: [
              Expanded(child: FeedCommentListFragment()),
              FetchMoreButtonWidget()
            ],
          ),
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: TextField(
                onTap: _handleShowModal,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: "Write Comment",
                  filled: true,
                  border: OutlineInputBorder(),
                ),
              ))
        ],
      ),
    );
  }
}
