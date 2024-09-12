part of 'create_media.page.dart';

class CreateMediaSuccessScreen extends StatelessWidget {
  const CreateMediaSuccessScreen({super.key});

  // TODO 1: 버튼을 누르면 다시 업로드 화면 보여주기
  // TODO 2  UI 수정
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
