part of '../index.dart';

class HashtagFragment extends StatefulWidget {
  const HashtagFragment({super.key});

  @override
  State<HashtagFragment> createState() => _HashtagFragmentState();
}

class _HashtagFragmentState extends State<HashtagFragment> {
  late TextEditingController _controller;
  late GlobalKey<FormState> _formKey;

  static const int _maxLength = 20;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String? _handleValidate(String? text) {
    if (text == null || text.isEmpty) {
      return 'hashtag is not given';
    } else if (context
        .read<CreateFeedBloc>()
        .state
        .hashtags
        .contains(text.trim())) {
      return 'hashtag is duplicated';
    } else if (text.contains('#')) {
      return 'hashtag can not contain #';
    }
    return null;
  }

  _handleAddHashtag() {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok != null && ok) {
      context.read<CreateFeedBloc>().add(
            InitEvent(
              hashtags: [
                ...context.read<CreateFeedBloc>().state.hashtags,
                _controller.text.trim()
              ],
            ),
          );
      _controller.clear();
    }
  }

  _handleRemoveHashtag(int index) => () {
        List<String> hashtags = [
          ...context.read<CreateFeedBloc>().state.hashtags
        ];
        hashtags.removeAt(index);
        context.read<CreateFeedBloc>().add(InitEvent(hashtags: hashtags));
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.tag),
                (12.0).w,
                Text(
                  'Hashtag',
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  maxLength: _maxLength,
                  validator: _handleValidate,
                  controller: _controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: context.colorScheme.primary,
                      ),
                      onPressed: _handleAddHashtag,
                    ),
                  ),
                ),
              ),
            ),
            if (state.hashtags.isNotEmpty)
              Wrap(
                children: List.generate(
                  state.hashtags.length,
                  (index) => InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8, bottom: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: context.colorScheme.secondaryContainer,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (8.0).w,
                          Text(state.hashtags[index],
                              style: context.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: context.colorScheme.onSecondary,
                              )),
                          IconButton(
                            onPressed: _handleRemoveHashtag(index),
                            icon: Icon(
                              Icons.delete_forever,
                              color: context.colorScheme.onSecondary,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
