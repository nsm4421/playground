part of 'page.dart';

class DisplayDiaryAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const DisplayDiaryAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        // 메타 데이터 입력 페이지로 이동 버튼
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list_outlined),
          tooltip: '필터',
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
