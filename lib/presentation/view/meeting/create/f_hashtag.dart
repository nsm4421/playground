part of 'page.dart';

class HashtagFragment extends StatefulWidget {
  const HashtagFragment({super.key});

  @override
  State<HashtagFragment> createState() => _HashtagFragmentState();
}

class _HashtagFragmentState extends State<HashtagFragment> {
  late TextEditingController _hashtagTec;

  @override
  void initState() {
    super.initState();
    _hashtagTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _hashtagTec.dispose();
  }

  _handleAddHashtag() {
    final text = _hashtagTec.text.trim();
    if (text.isEmpty) return;
    final hashtags = context.read<CreateMeetingCubit>().state.hashtags;
    if (hashtags.contains(text)) {
      customUtil.showWarningSnackBar(
          context: context, message: 'duplicated hashtag');
      return;
    }
    _hashtagTec.clear();
    context
        .read<CreateMeetingCubit>()
        .updateState(hashtags: [...hashtags, text]);
  }

  _handleDeleteHashtag(List<String> newHashtags) {
    context.read<CreateMeetingCubit>().updateState(hashtags: newHashtags);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const IconLabelWidget(iconData: Icons.tag_sharp, label: 'Hashtag'),
        // 해시태그 추가 버튼
        TextField(
            controller: _hashtagTec,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: _handleAddHashtag,
                    icon: const Icon(Icons.add)))),
        const SizedBox(height: 12),

        // 해시태그 목록
        EditHashtagsWidget(
            hashtags: state.hashtags, setHashtags: _handleDeleteHashtag)
      ]);
    });
  }
}
