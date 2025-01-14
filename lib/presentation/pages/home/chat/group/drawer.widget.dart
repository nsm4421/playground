part of '../../../export.pages.dart';

class GroupChatDrawerWidget extends StatelessWidget {
  const GroupChatDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Conversation",
                  style: context.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                Spacer(
                  flex: 1,
                ),
                CircleAvatar(), // TODO : 프사
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 500,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                    ),
                    title: Text("Username $index"),
                  );
                }),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.star_outline),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.exit_to_app),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notification_important_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
