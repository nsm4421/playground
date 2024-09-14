part of 'create_media.page.dart';

class CreateMediaSuccessScreen extends StatefulWidget {
  const CreateMediaSuccessScreen({super.key});

  @override
  State<CreateMediaSuccessScreen> createState() =>
      _CreateMediaSuccessScreenState();
}

class _CreateMediaSuccessScreenState extends State<CreateMediaSuccessScreen> {
  @override
  void initState() {
    super.initState();
    if (context.read<CreateMediaCubit>().state.mode == CreateMediaMode.feed) {
      // 피드 조회화면 새로고침
      context.read<DisplayFeedBloc>()
        ..add(RefreshEvent())
        ..add(FetchFeedEvent());
    }
  }

  // TODO 1: 버튼을 누르면 다시 업로드 화면 보여주기
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SUCCESS')),
      body: Center(
        child: Text('Create Success'),
      ),
    );
  }
}
