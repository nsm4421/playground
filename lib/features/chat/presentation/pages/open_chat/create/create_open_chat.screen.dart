part of "create_open_chat.page.dart";

class CreateOpenChatScreen extends StatefulWidget {
  const CreateOpenChatScreen({super.key});

  @override
  State<CreateOpenChatScreen> createState() => _CreateOpenChatScreenState();
}

class _CreateOpenChatScreenState extends State<CreateOpenChatScreen> {
  static const _maxHashtags = 5;
  late TextEditingController _titleTec;
  late TextEditingController _hashtagTec;
  late GlobalKey<FormState> _formKey;
  final List<String> _hashtags = [];

  @override
  void initState() {
    super.initState();
    _titleTec = TextEditingController();
    _hashtagTec = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _titleTec.dispose();
    _hashtagTec.dispose();
  }

  _handleAddHashtag() {
    final hashtag = _hashtagTec.text.trim();
    if (hashtag.isEmpty) {
      return;
    } else if (_hashtags.contains(hashtag)) {
      Fluttertoast.showToast(
          msg: "Duplicated Hashtag", gravity: ToastGravity.TOP);
      return;
    } else if (_hashtags.length >= _maxHashtags) {
      Fluttertoast.showToast(
          msg: "Too Many Hashtags", gravity: ToastGravity.TOP);
      return;
    } else {
      setState(() {
        _hashtags.add(hashtag);
        _hashtagTec.clear();
      });
    }
  }

  _handleDeleteHashtag(String text) {
    setState(() {
      _hashtags.remove(text);
    });
  }

  _handleSubmit() {
    _formKey.currentState?.save();
    if (_formKey.currentState!.validate()) {
      context.read<OpenChatBloc>().add(CreateOpenChatEvent(
          title: _titleTec.text.trim(), hashtags: _hashtags));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Chat Room"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (String? text) =>
                      (text != null && text.isNotEmpty) ? null : "Press Email",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      decorationThickness: 0,
                      color: Theme.of(context).colorScheme.primary),
                  decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.primary)),
                  controller: _titleTec,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      decorationThickness: 0,
                      color: Theme.of(context).colorScheme.primary),
                  decoration: InputDecoration(
                      labelText: "Hashtag",
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.primary),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add,
                            color: Theme.of(context).colorScheme.primary),
                        onPressed: _handleAddHashtag,
                      )),
                  controller: _hashtagTec,
                ),
              ),

              // 해시태그 목록
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child:
                    HashtagsWidget(_hashtags, onDelete: _handleDeleteHashtag),
              ),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(indent: 10, endIndent: 10),
              ),

              // 제출 버튼
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).colorScheme.tertiaryContainer)),
                    onPressed: _handleSubmit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Submit",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary)),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
