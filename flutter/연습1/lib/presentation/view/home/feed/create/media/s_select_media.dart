part of '../index.dart';

class SelectMediaScreen extends StatelessWidget {
  const SelectMediaScreen({super.key, required this.handleJumpPage});

  final void Function() handleJumpPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
        builder: (context, state) {
      return Stack(
        children: [
          Scaffold(
            appBar: const SelectedImagesFragment(),
            body: state.currentAsset == null
                ? const Center(child: CircularProgressIndicator())
                : const Column(
                    children: [
                      CurrentAssetFragment(),
                      SelectAssetPathWidget(),
                      Expanded(child: DisplayAssetFragment()),
                    ],
                  ),
          ),

          /// 닫기 버튼
          Positioned(
            top: context.viewPadding.top,
            left: 12,
            child: const PopButtonWidget(),
          ),

          /// 다음 페이지로
          if (state.images.isNotEmpty)
            Positioned(
              top: context.viewPadding.top,
              right: 12,
              child: JumpButtonWidget(handleJumpPage),
            ),
        ],
      );
    });
  }
}
