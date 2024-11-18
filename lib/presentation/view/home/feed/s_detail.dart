part of 'index.dart';

class FeedDetailScreen extends StatefulWidget {
  const FeedDetailScreen(this.feed, {super.key});

  final FeedEntity feed;

  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  late TextEditingController _textEditingController;

  @override
  initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeedDetailWidget(widget.feed),
            // TODO : 댓글 보여주기
          ],
        ),
      ),
      bottomNavigationBar: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              // TODO : 댓글작성하기
            },
            icon: Icon(Icons.check),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
