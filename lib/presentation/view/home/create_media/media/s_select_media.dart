part of '../index.dart';

class SelectMediaScreen extends StatelessWidget {
  const SelectMediaScreen({super.key, required this.handleJumpPage});

  final void Function() handleJumpPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SelectedImagesFragment(),
      body: const Column(
        children: [
          CurrentAssetFragment(),
          SelectAssetPathWidget(),
          Expanded(child: DisplayAssetFragment()),
        ],
      ),
      floatingActionButton: NavigateFabWidget(onTap: handleJumpPage),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
