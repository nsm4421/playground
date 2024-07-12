part of 'feed_comment.page.dart';

class FeedCommentScreen extends StatefulWidget {
  const FeedCommentScreen(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  State<FeedCommentScreen> createState() => _FeedCommentScreenState();
}

class _FeedCommentScreenState extends State<FeedCommentScreen> {
  static const int _maxLength = 1000;
  late TextEditingController _tec;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
    _focusNode.dispose();
  }

  _handleContent(String content) {
    context.read<UploadFeedCommentCubit>().setContent(content);
  }

  _handleKeyboardDown() {
    FocusScope.of(context).unfocus();
  }

  _handleSubmit() async {
    context.read<UploadFeedCommentCubit>().upload();
    _tec.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 댓글 모록
        Expanded(
          child: GestureDetector(
            onTap: _handleKeyboardDown,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const CommentListFragment(),
            ),
          ),
        ),

        // 댓글 텍스트 필드
        Column(children: [
          TextField(
            controller: _tec,
            onChanged: _handleContent,
            minLines: 1,
            maxLines: 3,
            maxLength: _maxLength,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                counterText: '',
                suffixIcon: IconButton(
                  onPressed: _handleSubmit,
                  icon: const Icon(Icons.send),
                )),
          ),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom))
        ])
      ],
    );
  }
}
