part of '../../../export.pages.dart';

class CreateFeedScreen extends StatefulWidget {
  const CreateFeedScreen({super.key});

  @override
  State<CreateFeedScreen> createState() => _CreateFeedScreenState();
}

class _CreateFeedScreenState extends State<CreateFeedScreen> {
  static const int _contentMaxLength = 1000;
  static const int _hashtagMaxLength = 30;

  late TextEditingController _contentController;
  late TextEditingController _hashtagController;
  late GlobalKey<FormState> _contentFormKey;
  late GlobalKey<FormState> _hashtagFormKey;

  List<String> _hashtags = [];

  static const int _maxHashtagNum = 5;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
    _hashtagController = TextEditingController();
    _contentFormKey = GlobalKey<FormState>(debugLabel: 'content key');
    _hashtagFormKey = GlobalKey<FormState>(debugLabel: 'hashtag key');
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
    _hashtagController.dispose();
  }

  String? _handleValidateContent(String? text) {
    if (text == null || text.isEmpty) {
      return 'text is not given';
    }
    return null;
  }

  String? _handleValidateHashtag(String? text) {
    // TODO : 특수문자 못쓰게 막기
    if (text == null || text.isEmpty) {
      return 'hashtag is not given';
    } else if (_hashtags.length >= _maxHashtagNum) {
      return 'too many hashtag';
    } else {
      return null;
    }
  }

  _handleAddHashtag() {
    _hashtagFormKey.currentState?.save();
    final ok = _hashtagFormKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    setState(() {
      _hashtags.add(_hashtagController.text.trim());
    });
  }

  _handleSubmit() {
    _contentFormKey.currentState?.save();
    final ok = _contentFormKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<CreateFeedCubit>().submit(
        content: _contentController.text.trim(),
        hashtags: _hashtags,
        files: [] // TODO : 파일선택 기능
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Feed"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Form(
                key: _contentFormKey,
                child: TextFormField(
                  controller: _contentController,
                  validator: _handleValidateContent,
                  maxLength: _contentMaxLength,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          "content on here(max $_contentMaxLength characters)",
                      labelText: "CONTENT"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Form(
                key: _hashtagFormKey,
                child: TextFormField(
                  controller: _hashtagController,
                  validator: _handleValidateHashtag,
                  maxLength: _hashtagMaxLength,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          "content on here(max $_hashtagMaxLength characters)",
                      labelText: "HASHTAG",
                      suffixIcon: IconButton(
                          onPressed: _handleAddHashtag, icon: Icon(Icons.add))),
                ),
              ),
            ),
            Wrap(
              children: _hashtags
                  .map((item) => Container(
                        margin: const EdgeInsets.only(right: 12, top: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.tag),
                            8.width,
                            Text(item),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            ElevatedButton(
                onPressed: _handleSubmit, child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}
