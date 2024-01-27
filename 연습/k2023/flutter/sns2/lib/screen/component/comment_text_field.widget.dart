import 'package:flutter/material.dart';
import 'package:my_app/configurations.dart';
import 'package:my_app/repository/feed/feed.repository.dart';

// parent comment id == null → parent comment
// parent comment id != null → child comment
class CommentTextFieldWidget extends StatefulWidget {
  const CommentTextFieldWidget({super.key, required this.fid, this.parentCid});

  final String fid; // feed id
  final String? parentCid; // parent comment id

  @override
  State<CommentTextFieldWidget> createState() => _CommentTextFieldWidgetState();
}

class _CommentTextFieldWidgetState extends State<CommentTextFieldWidget> {
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

  _handleSubmitComment() async {
    // check content
    final content = _tec.text.trim();
    if (content.isEmpty) {
      return;
    }
    //save comment
    await getIt<FeedRepository>()
        .saveFeedComment(
            fid: widget.fid, parentCid: widget.parentCid, content: content)
        .then((_) {
      // when saving comment completed, pop text field widget
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          // content text field
          TextFormField(
            controller: _tec,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 8,
            maxLength: 1000,
            style: const TextStyle(decorationThickness: 0, fontSize: 18),
            decoration: InputDecoration(
              counterText: '',
              hintText: 'write comment (max length 1000)',
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              contentPadding: const EdgeInsets.only(right: 90),
            ),
          ),
          // submit button
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
                icon: Icon(Icons.send,
                    color: Theme.of(context).colorScheme.primary),
                onPressed: _handleSubmitComment),
          )
        ],
      );
}
