part of "create_feed_comment.page.dart";

class CreateFeedCommentScreen extends StatefulWidget {
  const CreateFeedCommentScreen({super.key});

  @override
  State<CreateFeedCommentScreen> createState() =>
      _CreateFeedCommentScreenState();
}

class _CreateFeedCommentScreenState extends State<CreateFeedCommentScreen> {
  late TextEditingController _tec;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handleSubmit() async {
    final content = _tec.text.trim();
    if (content.isEmpty) {
      return;
    }
    context.read<CreateCommentCubit>().submit(content);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: TextField(
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(decorationThickness: 0),
        controller: _tec,
        decoration: InputDecoration(
            labelText: "COMMENT",
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: _handleSubmit)),
        minLines: 1,
        maxLines: 5,
        maxLength: 1000,
      ),
    );
  }
}
