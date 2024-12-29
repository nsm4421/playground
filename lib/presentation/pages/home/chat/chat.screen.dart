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
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 500,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  context.push('${Routes.chatRoom.path}?chatId=test');
                },
                leading: const CircleAvatar(
                  radius: 20,
                ),
                title: Text(
                  "Opponent User Id",
                  style: context.textTheme.titleMedium
                      ?.copyWith(color: context.colorScheme.primary),
                ),
                subtitle: Text(
                  "Last Messages",
                  style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.secondary,
                      overflow: TextOverflow.ellipsis),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              );
            }),
      ),
    );
  }
}
