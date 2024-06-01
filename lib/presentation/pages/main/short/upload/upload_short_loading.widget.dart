part of 'upload_short.screen.dart';

class UploadShortLoadingWidget extends StatelessWidget {
  const UploadShortLoadingWidget(this.state, {super.key});

  final UploadShortState state;

  @override
  Widget build(BuildContext context) {
    assert(state.status == Status.loading);
    return const Center(child: CircularProgressIndicator());
  }
}
