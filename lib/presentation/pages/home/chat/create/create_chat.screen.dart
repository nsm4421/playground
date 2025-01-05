part of '../../../export.pages.dart';

class CreateGroupChatScreen extends StatefulWidget {
  const CreateGroupChatScreen({super.key});

  @override
  State<CreateGroupChatScreen> createState() => _CreateGroupChatScreenState();
}

class _CreateGroupChatScreenState extends State<CreateGroupChatScreen> {
  static const int _titleMinLength = 3;
  static const int _titleMaxLength = 50;
  static const int _hashtagMaxLength = 30;
  static const int _maxHashtagNum = 3;
  late TextEditingController _titleController;
  late TextEditingController _hashtagController;

  String? _titleErrorText;
  String? _hashtagErrorText;

  List<String> _hashtags = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _hashtagController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _hashtagController.dispose();
  }

  _handleAddHashtag() {
    final text = _hashtagController.text.trim();
    if (text.isEmpty) {
      _hashtagErrorText = 'hashtag is not given';
    } else if (_hashtags.contains(text)) {
      _hashtagErrorText = 'duplicated hashtag';
    } else if (_hashtags.length >= _maxHashtagNum) {
      _hashtagErrorText = 'too many hashtag';
    } else {
      _hashtagErrorText = null;
      _hashtags.add(text);
      _hashtagController.clear();
    }
    setState(() {});
  }

  void Function() _handleDeleteHashtag(int index) => () {
        final newHashtags = [..._hashtags];
        newHashtags.removeAt(index);
        setState(() {
          _hashtags = newHashtags;
        });
      };

  _handleSubmit() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      setState(() {
        _titleErrorText = 'title is not given';
      });
      return;
    } else if (title.length < _titleMinLength) {
      setState(() {
        _titleErrorText =
            'title is too short (use at least $_titleMinLength characters)';
      });
      return;
    }
    await context
        .read<CreateChatCubit>()
        .submit(title: title, hashtags: _hashtags);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Chat"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: TextFormField(
                controller: _titleController,
                maxLength: _titleMaxLength,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.title),
                    hintText: "Title",
                    border: const OutlineInputBorder(),
                    errorText: _titleErrorText),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: TextFormField(
                controller: _hashtagController,
                maxLength: _hashtagMaxLength,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.tag),
                  suffixIcon: IconButton(
                    onPressed: _handleAddHashtag,
                    icon: const Icon(Icons.add),
                  ),
                  hintText: "Tags",
                  border: const OutlineInputBorder(),
                  errorText: _hashtagErrorText,
                ),
              ),
            ),
            if (_hashtags.isNotEmpty)
              HashtagListWidget(
                hashtags: _hashtags,
                handleDelete: _handleDeleteHashtag,
              )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
          onPressed: _handleSubmit,
          child: const Icon(Icons.add_circle_outline)),
    );
  }
}
