part of "chat.page.dart";

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CHAT"),
        actions: [
          IconButton(
              onPressed: () {
                context.push(RoutePaths.openChat.path);
              }, icon: const Icon(Icons.people_alt_outlined))
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                    onTap: () {},
                    title: const Text("test"),
                  ))
        ],
      ),
    );
  }
}
