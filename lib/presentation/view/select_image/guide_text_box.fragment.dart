part of '../index.page.dart';

class GuideTextBoxFragment extends StatelessWidget {
  const GuideTextBoxFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageToTextBloc, ImageToTextState>(
        builder: (context, state) {
      if (state.status == Status.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.originalText.isNotEmpty) {
        return ElevatedButton(onPressed: () {}, child: const Text('통역하기'));
      } else {
        return const SizedBox();
      }
    });
  }
}
