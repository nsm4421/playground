part of '../image_to_text.page.dart';

class TranslatedTextFragment extends StatelessWidget {
  const TranslatedTextFragment(this.currentBlock, {super.key});

  final Block currentBlock;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(currentBlock.originalText),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(currentBlock.translatedText),
        ),
      ],
    );
  }
}
