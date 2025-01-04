part of '../../../export.pages.dart';

class EditMetaDataFragment extends StatefulWidget {
  const EditMetaDataFragment({super.key});

  @override
  State<EditMetaDataFragment> createState() => _EditMetaDataFragmentState();
}

class _EditMetaDataFragmentState extends State<EditMetaDataFragment> {
  static const int _maxLength = 30;
  static const int _maxCount = 5;
  late TextEditingController _controller;
  late GlobalKey<FormState> _formKey;
  late List<String> _hashtags;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _hashtags = context.read<CreateFeedCubit>().state.hashtags;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String? _handleValidate(String? text) {
    if (text == null || text.isEmpty) {
      return 'hashtag is not given';
    } else if (_hashtags.contains(text)) {
      return 'duplicated hashtag';
    } else if (_hashtags.length >= _maxCount) {
      return 'too many hashtags';
    }
    return null;
  }

  void _handleAddHashtag() {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    setState(() {
      _hashtags.add(_controller.text.trim());
    });
    _controller.clear();
    context.read<CreateFeedCubit>().updateHashtags(_hashtags);
  }

  _handleDeleteHashtag(int index) => () {
        setState(() {
          _hashtags.removeAt(index);
        });
        context.read<CreateFeedCubit>().updateHashtags(_hashtags);
      };

  _handleSubmit() async {
    final futures = context
        .read<SelectMediaCubit>()
        .state
        .selected
        .map((item) async => await item.file.then((res) => res!));
    await Future.wait(futures).then((files) {
      context.read<CreateFeedCubit>().updateFiles(files);
    }).then((_) async {
      await context.read<CreateFeedCubit>().submit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // tags
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    validator: _handleValidate,
                    maxLength: _maxLength,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.tag),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _handleAddHashtag,
                        )),
                  ),
                ),
                if (_hashtags.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    child: Wrap(
                      children: List.generate(_hashtags.length, (index) {
                        final text = _hashtags[index];
                        return Container(
                          margin: const EdgeInsets.only(left: 8, top: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(text),
                              (6.width),
                              IconButton(
                                  onPressed: _handleDeleteHashtag(index),
                                  icon: const Icon(Icons.delete_outline))
                            ],
                          ),
                        );
                      }),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _handleSubmit, label: Text("Share")),
    );
  }
}
