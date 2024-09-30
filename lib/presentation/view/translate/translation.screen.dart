part of '../index.page.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('통역하기')),
      body: BlocBuilder<ImageToTextBloc, ImageToTextState>(
        builder: (context, state) {
          return Column(
            children: [
              SelectedImageWidget(
                  imageWidth: imageSize,
                  imageHeight: imageSize,
                  selectedImage: state.selectedImage!,
                  selectedIndex: state.selectedIndex!,
                  blocks: state.blocks),
              Expanded(
                  child: Column(
                children: [


                ],
              ))
            ],
          );
        },
      ),
    );
  }
}
