part of 'index.dart';

class CreateMediaScreen extends StatelessWidget {
  const CreateMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Media'),
      ),
      body: Column(
        children: [
          SizedBox(height: context.width, child: const SelectedImageWidget()),
          const Expanded(child: DisplayAssetWidget()),
        ],
      ),
      floatingActionButton: const FabWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
