part of 'page.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  static const _maxLength = 200;
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

  _handleJoin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          controller: _tec,
          minLines: 1,
          maxLines: 3,
          maxLength: _maxLength,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: _handleJoin,
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              hintText: 'send comment')),
    ));
  }
}
