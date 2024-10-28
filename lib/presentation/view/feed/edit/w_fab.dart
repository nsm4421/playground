part of 'page.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditFeedBloc, EditFeedState>(
        builder: (context, state) {
      return Align(
          alignment: Alignment.bottomRight,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            /// 이미지 업로드 아이콘
            RoundIconButtonWidget(
                iconData: Icons.add_photo_alternate_outlined,
                isLoading: !state.status.ok,
                voidCallback: () async {
                  await customUtil
                      .pickImageAndReturnCompressedImage()
                      .then((res) {
                    if (res != null) {
                      context.read<EditFeedBloc>().add(AddAssetEvent(res));
                    }
                  });
                }),

            /// 제출 아이콘
            RoundIconButtonWidget(
                iconData: Icons.upload,
                isLoading: !state.status.ok,
                voidCallback: () async {
                  context.read<EditFeedBloc>().add(SubmitFeedEvent());
                }),
          ]));
    });
  }
}
