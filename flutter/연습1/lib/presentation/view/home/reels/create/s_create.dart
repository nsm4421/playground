part of 'index.dart';

class CreateReelsScreen extends StatelessWidget {
  const CreateReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const SingleChildScrollView(
          child: Column(
            children: [
              CurrentVideoFragment(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                child: SelectAssetPathWidget(),
              ),
              DisplayAssetFragment()
            ],
          ),
        ),
      ),
      bottomNavigationBar: const EditCaptionFragment(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Align(
        alignment: Alignment.bottomRight,
        child: SubmitButtonWidget(),
      ),
    );
  }
}
