part of 'index.page.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
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
              onPressed: context.read<ImageToTextCubit>().reset,
              icon: const Icon(Icons.rotate_left_outlined)),
          IconButton(
              onPressed: () {
                customUtil.logger.i(
                    context.read<ImageToTextCubit>().state.blocks.first.text);
              },
              icon: const Icon(Icons.abc))
        ],
      ),
      body: Column(
        children: [
          // 이미지 미리보기
          Container(
            width: imageSize,
            height: imageSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer),
            child: SelectedImageFragment(imageSize),
          ),

          // 추출된 텍스트
          const Expanded(child: ExtractedTextFragment())
        ],
      ),
    );
  }
}
