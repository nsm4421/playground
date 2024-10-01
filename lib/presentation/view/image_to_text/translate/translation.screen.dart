part of '../image_to_text.page.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: const Text('통역하기')),
        body: BlocListener(listener: (BuildContext context, state) {
          if (context
              .read<ImageToTextBloc>()
              .selectedBlock
              .translatedText
              .isEmpty) {
            context.read<ImageToTextBloc>().add(TranslateEvent());
          }
        }, child: BlocBuilder<ImageToTextBloc, ImageToTextState>(
            builder: (context, state) {
          return Column(children: [
            SelectedImageWidget(
                imageWidth: imageSize,
                imageHeight: imageSize,
                selectedImage: state.selectedImage!,
                selectedIndex: state.selectedIndex!,
                blocks: state.blocks),
            Expanded(
                child: Center(
                    child: state.status.ok
                        ? TranslatedTextFragment(
                            context.read<ImageToTextBloc>().selectedBlock)
                        : const CircularProgressIndicator()))
          ]);
        })));
  }
}
