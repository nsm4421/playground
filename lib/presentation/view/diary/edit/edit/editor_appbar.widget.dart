part of '../index.page.dart';

class EditorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditorAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDiaryBloc, EditDiaryState>(
        builder: (context, state) {
      return AppBar(
        title: Text('Diary'),
        elevation: 0,
        actions: [
          // 메타 데이터 입력 페이지로 이동 버튼
          IconButton(
            onPressed: () {
              context.read<EditDiaryBloc>().add(MoveToMetaDataPage());
            },
            icon: const Icon(Icons.chevron_right_rounded),
            tooltip: '다음 단계로',
          )
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
