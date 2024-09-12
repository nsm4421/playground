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
      return state.step == CreateMediaStep.done
          // 업로드를 완료한 경우
          ? const UploadSuccessScreen()
          // 업로드 중인 경우
          : Stack(alignment: Alignment.bottomCenter, children: [
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
