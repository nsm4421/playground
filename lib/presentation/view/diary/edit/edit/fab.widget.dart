part of '../edit_diary.page.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({super.key});

  static const _maxPageNum = 5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDiaryBloc, EditDiaryState>(
        builder: (context, state) {
      return Align(
          alignment: Alignment.bottomRight,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            /// 이미지 업로드 아이콘
            IconBoxWidget(
                iconData: Icons.add_photo_alternate_outlined,
                isLoading: !state.status.ok,
                voidCallback: () async {
                  if (!state.status.ok) return;
                  await customUtil
                      .pickImageAndReturnCompressedImage()
                      .then((res) {
                    if (res == null) return;
                    context.read<EditDiaryBloc>().add(UpdateImageEvent(
                        index: state.currentIndex, image: res));
                  });
                }),

            /// 페이지 추가 아이콘
            if (state.pages.length < _maxPageNum)
              IconBoxWidget(
                  iconData: Icons.plus_one,
                  isLoading: !state.status.ok,
                  voidCallback: () async {
                    context.read<EditDiaryBloc>().add(AddPageEvent());
                  }),

            /// 페이지 삭제 아이콘
            if (state.pages.length > 1)
              IconBoxWidget(
                  iconData: Icons.delete_forever,
                  isLoading: !state.status.ok,
                  voidCallback: () async {
                    context.read<EditDiaryBloc>().add(DeletePageEvent());
                  }),
          ]));
    });
  }
}

class IconBoxWidget extends StatelessWidget {
  const IconBoxWidget(
      {super.key,
      required this.voidCallback,
      required this.iconData,
      this.iconSize = 40,
      this.iconColor = Colors.white,
      this.bgColor = Colors.blueGrey,
      this.isLoading = false});

  final void Function() voidCallback;
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final Color bgColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: voidCallback,
        icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            child: isLoading
                ? Transform.scale(
                    scale: 0.5, child: const CircularProgressIndicator())
                : Icon(iconData, color: iconColor, size: iconSize)));
  }
}
