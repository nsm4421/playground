part of 'page.dart';

class EditDiaryScreen extends StatelessWidget {
  const EditDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              /// Assets
              Padding(
                  padding: EdgeInsets.only(left: 12, top: 60),
                  child: DisplayAvatarFragment(120)),

              /// 본문
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12, top: 30),
                child: EditorContentFragment(),
              ),

              /// 해시태그
              Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 30),
                  child: EditorHashtagFragment())
            ]))),
        floatingActionButton: BlocBuilder<EditDiaryBloc, EditDiaryState>(
            builder: (context, state) {
          return Align(
              alignment: Alignment.bottomRight,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                /// 이미지 업로드 아이콘
                FabItemWidget(
                    iconData: Icons.add_photo_alternate_outlined,
                    isLoading: !state.status.ok,
                    voidCallback: () async {
                      await customUtil
                          .pickImageAndReturnCompressedImage()
                          .then((res) {
                        if (res != null) {
                          context.read<EditDiaryBloc>().add(AddAssetEvent(res));
                        }
                      });
                    }),

                /// 제출 아이콘
                FabItemWidget(
                    iconData: Icons.upload,
                    isLoading: !state.status.ok,
                    voidCallback: () async {
                      context.read<EditDiaryBloc>().add(SubmitDiaryEvent());
                    }),
              ]));
        }));
  }
}
