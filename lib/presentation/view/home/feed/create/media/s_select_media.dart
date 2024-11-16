part of '../index.dart';

class SelectMediaScreen extends StatelessWidget {
  const SelectMediaScreen({super.key, required this.handleJumpPage});

  final void Function() handleJumpPage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Scaffold(
          appBar: SelectedImagesFragment(),
          body: Column(
            children: [
              CurrentAssetFragment(),
              SelectAssetPathWidget(),
              Expanded(child: DisplayAssetFragment()),
            ],
          ),
        ),
        Positioned(
          top: context.viewPadding.top,
          left: 12,
          child: const PopButtonWidget(),
        ),
        Positioned(
          top: context.viewPadding.top,
          right: 12,
          child: JumpButtonWidget(handleJumpPage),
        ),
      ],
    );
  }
}
