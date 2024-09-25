part of 'feed.page.dart';

enum MoreIconMenu {
  edit(label: '수정하기', icon: Icons.edit, showForAuthor: true),
  delete(label: '삭제하기', icon: Icons.delete, showForAuthor: true),
  report(label: '신고하기', icon: Icons.report);

  final String label;
  final IconData icon;
  final bool showForAuthor; // 작성자에게만 보여줄지 여부

  const MoreIconMenu(
      {required this.label, required this.icon, this.showForAuthor = false});
}

class MoreIconWidget extends StatefulWidget {
  const MoreIconWidget(
      {super.key, required FeedEntity feed, required bool isMyFeed})
      : _feed = feed,
        _isMyFeed = isMyFeed;

  final FeedEntity _feed;
  final bool _isMyFeed;

  @override
  State<MoreIconWidget> createState() => _MoreIconWidgetState();
}

class _MoreIconWidgetState extends State<MoreIconWidget> {
  _handleSelect(MoreIconMenu? menu) {
    if (context.read<DisplayFeedBloc>().state.status == Status.loading ||
        context.read<DisplayFeedBloc>().state.status == Status.error) return;
    switch (menu) {
      case MoreIconMenu.edit:
        // TODO : 피드 수정기능
        () {};
      case MoreIconMenu.delete:
        log('피드 삭제 요청');
        context.read<DisplayFeedBloc>().add(DeleteFeedEvent(widget._feed.id!));
        getIt<CustomSnakbar>().success(title: '피드가 삭제되었습니다');
      case MoreIconMenu.report:
        // TODO : 신고기능
        () {};
      case null:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MoreIconMenu?>(
        onSelected: _handleSelect,
        itemBuilder: (context) => MoreIconMenu.values
            .where((item) => widget._isMyFeed ? true : (!item.showForAuthor))
            .map((item) => PopupMenuItem<MoreIconMenu>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: CustomSpacing.lg),
                    child: Row(
                      children: [
                        Icon(item.icon, size: CustomTextSize.lg),
                        const Spacer(),
                        Text(item.label,
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                  ),
                ))
            .toList(),
        child: Icon(Icons.more_vert, size: CustomTextSize.xl));
  }
}
