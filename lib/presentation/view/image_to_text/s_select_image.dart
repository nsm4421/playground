part of 'page.dart';

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
          leading: IconButton(
            onPressed: (){
              context.read<ImageToTextBloc>().add(InitEvent());
            },
            icon: const Icon(Icons.chevron_left),
          ),
          title: const Text('이미지를 선택해주세요'),
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

          const Expanded(child: Center(child: GuideTextBoxFragment()))
        ]));
  }
}
