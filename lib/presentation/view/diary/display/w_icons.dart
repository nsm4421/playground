part of 'page.dart';

class IconsWidget extends StatefulWidget {
  const IconsWidget(this._diary, {super.key});

  final DiaryEntity _diary;

  @override
  State<IconsWidget> createState() => _IconsWidgetState();
}

class _IconsWidgetState extends State<IconsWidget> {
  // TODO
  _handleLike() {}

  _handleDM() {}

  _handleComment() async {
    context.read<HomeBottomNavCubit>().handleVisible(false);
    await showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => DiaryCommentPage(widget._diary)).then((_) {
      context.read<HomeBottomNavCubit>().handleVisible(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 6),
            child: IconButton(
                icon: const Icon(Icons.favorite_border), onPressed: () {})),
        IconButton(
            icon: const Icon(Icons.comment_outlined),
            onPressed: _handleComment),
        IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {})
      ],
    );
  }
}
