part of "display_private_chat.page.dart";

class LastPrivateChatListFragment extends StatelessWidget {
  const LastPrivateChatListFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUid = context.read<AuthBloc>().currentUser!.id;
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
                  final opponent = item.sender?.id == currentUid
                      ? PresenceEntity.fromEntity(item.receiver!)
                      : PresenceEntity.fromEntity(item.sender!);
                  return ListTile(
                    onTap: () {
                      context.push(RoutePaths.privateChatRoom.path,
                          extra: opponent);
                    },
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
