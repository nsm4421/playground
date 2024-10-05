part of '../index.page.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<ImageToTextBloc>().add(InitEvent());
            },
            icon: const Icon(Icons.chevron_left),
          ),
          title: const Text('통역하기'),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<ImageToTextBloc>().add(UnSelectImageEvent());
                },
                icon: const Icon(Icons.rotate_left_outlined))
          ],
        ),
        body: BlocListener<ImageToTextBloc, ImageToTextState>(
            listener: (BuildContext context, state) {
              if (state.step == ImageToTextStep.translate &&
                  context
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
                  child: state.status.ok
                      ? SingleChildScrollView(
                    child: TranslatedTextFragment(
                        context
                            .read<ImageToTextBloc>()
                            .selectedBlock),
                  )
                      : const CircularProgressIndicator(),
                )
              ]);
            })));
  }
}
