part of '../image_to_text.page.dart';

class SelectImageScreen extends StatefulWidget {
  const SelectImageScreen({super.key});

  @override
  State<SelectImageScreen> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Image2Text Demo'),
          elevation: 0,
          actions: [
            // 리셋버튼
            IconButton(
                onPressed: () {
                  context.read<ImageToTextBloc>().add(UnSelectImageEvent());
                },
                icon: const Icon(Icons.rotate_left_outlined))
          ],
        ),
        body: Column(children: [
          // 이미지 미리보기
          Container(
            width: imageSize,
            height: imageSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer),
            child: DisplayImageFragment(imageSize),
          ),

          const Expanded(child: GuideTextBoxFragment())
        ]));
  }
}
