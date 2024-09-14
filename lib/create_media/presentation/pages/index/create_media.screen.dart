part of 'create_media.page.dart';

class CreateMediaScreen extends StatefulWidget {
  const CreateMediaScreen({super.key});

  @override
  State<CreateMediaScreen> createState() => _CreateMediaScreenState();
}

class _CreateMediaScreenState extends State<CreateMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CreateMediaCubit, CreateMediaState>(
        builder: (context, state) {
      return Stack(alignment: Alignment.bottomCenter, children: [
        switch (state.mode) {
          CreateMediaMode.feed => const CreateFeedPage(),
          CreateMediaMode.reels => const CreateReelsPage(),
        },
        // media 선택화면에서는 화면 전환 버튼을 보여줌
        if (state.step == CreateMediaStep.selectMedia)
          const SelectModeButtonWidget()
      ]);
    }));
  }
}
