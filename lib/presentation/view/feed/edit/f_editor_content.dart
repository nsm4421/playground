part of 'page.dart';

class EditorContentFragment extends StatefulWidget {
  const EditorContentFragment({super.key});

  @override
  State<EditorContentFragment> createState() => _EditorContentFragmentState();
}

class _EditorContentFragmentState extends State<EditorContentFragment> {
  late TextEditingController _tec;

  static const int _maxLength = 1000;
  static const int _minLine = 5;
  static const int _maxLine = 10;

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

  _handleOnTap() async {
    await showModalBottomSheet<String?>(
        showDragHandle: true,
        context: context,
        builder: (_) => EditContentWidget(_tec.text)).then((res) {
      if (res == null) return;
      _tec.text = res;
      context.read<EditFeedBloc>().add(UpdateEditorEvent(content: res));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditFeedBloc, EditFeedState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            _tec.clear();
          }
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Icon(Icons.abc),
            const SizedBox(width: 12),
            Text('Content',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ]),
          TextField(
              readOnly: true,
              onTap: _handleOnTap,
              controller: _tec,
              minLines: _minLine,
              maxLines: _maxLine,
              maxLength: _maxLength,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  hintText: 'what did you do today?'))
        ]));
  }
}

class EditContentWidget extends StatefulWidget {
  const EditContentWidget(this._initialValue, {super.key});

  final String _initialValue;

  @override
  State<EditContentWidget> createState() => _EditContentWidgetState();
}

class _EditContentWidgetState extends State<EditContentWidget> {
  static const int _maxLength = 1000;
  static const int _minLines = 5;
  static const int _maxLines = 20;

  late TextEditingController _tec;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _tec.text = widget._initialValue;
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
  }

  Future<bool> _handleOnWillPop() async {
    context.pop<String>(_tec.text.trim());
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleOnWillPop,
      child: Padding(
          padding: MediaQuery.of(context)
              .viewInsets
              .copyWith(top: 12, left: 8, right: 8),
          child: TextField(
              controller: _tec,
              minLines: _minLines,
              maxLines: _maxLines,
              maxLength: _maxLength,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 1.5,
                    decorationThickness: 0,
                    fontWeight: FontWeight.w700,
                  ))),
    );
  }
}
