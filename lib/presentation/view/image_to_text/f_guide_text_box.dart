part of 'page.dart';

class GuideTextBoxFragment extends StatelessWidget {
  const GuideTextBoxFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageToTextBloc, ImageToTextState>(
        builder: (context, state) {
      if (state.status == Status.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.originalText.isEmpty) {
        return const Center(child: Text('No Text Extracted'));
      } else if (state.originalText.isNotEmpty) {
        return ElevatedButton(
            onPressed: () {
              context.read<ImageToTextBloc>().add(TranslateEvent());
            },
            child: const Text('통역하기'));
      } else {
        return const Center(child: Text('Error'));
      }
    });
  }
}
