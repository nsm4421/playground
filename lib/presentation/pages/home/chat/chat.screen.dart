part of '../../export.pages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: SingleChildScrollView(
        child: ElevatedButton(
          onPressed: () {
            context.push('${Routes.chatRoom.path}/test');
          },
          child: Text("TEST"),
        ),
      ),
    );
  }
}
