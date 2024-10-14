part of 'page.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {
          context.push(Routes.createMeeting.path);
        }, icon: Icon(Icons.edit))],
      ),
    );
  }
}
