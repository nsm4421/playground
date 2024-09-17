part of 'create_feed.page.dart';

class UnAuthorizedScreen extends StatelessWidget {
  const UnAuthorizedScreen({super.key});

  // TODO : 권한 오류처리
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('인증이 허가되지 않았습니다'),
      ),
    );
  }
}
