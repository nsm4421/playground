part of "display_private_chat.page.dart";

class LastPrivateChatListFragment extends StatelessWidget {
  const LastPrivateChatListFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayPrivateChatBloc, DisplayPrivateChatState>(
      builder: (context, state) {
        final messages = state.lastMessages;
        switch (state.status) {
          case Status.initial:
          case Status.success:
            return ListView.builder(
                shrinkWrap: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final item = messages[index];
                  return ListTile(
                    onTap: () {},
                    title: Text(item.content ?? "content"),
                  );
                });
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.error:
            return const SizedBox();
        }
      },
    );
  }
}
