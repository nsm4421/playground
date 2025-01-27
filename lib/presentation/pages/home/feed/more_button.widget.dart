part of '../../export.pages.dart';

class FeedMoreButtonWidget extends StatelessWidget {
  const FeedMoreButtonWidget(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          builder: (modalCtx) {
            context.read<HomeBottomNavCubit>().handleVisibility(false);
            return Scaffold(
              body: Column(
                children: [
                  /// 삭제 버튼
                  ListTile(
                    onTap: () {
                      context
                          .read<DisplayFeedBloc>()
                          .add(DeleteDisplayDataEvent<FeedEntity>(_feed));
                      if (modalCtx.canPop()) modalCtx.pop();
                    },
                    leading: const Icon(Icons.delete),
                    title: Text(
                      "Delete Feed",
                      style: context.textTheme.labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),

                  /// 수정버튼
                  ListTile(
                    // TODO : 수정 페이지로 이동시키기
                    onTap: () {},
                    leading: const Icon(Icons.edit),
                    title: Text(
                      "Modify Feed",
                      style: context.textTheme.labelLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          },
        ).whenComplete(() {
          context.read<HomeBottomNavCubit>().handleVisibility(true);
        });
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
