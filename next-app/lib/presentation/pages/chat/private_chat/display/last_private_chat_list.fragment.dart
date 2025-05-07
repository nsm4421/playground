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
                    onTap: () {
                      context.push(RoutePaths.privateChatRoom.path,
                          extra: item.opponent);
                    },
                    leading: (item.opponent?.profileImage == null)
                        ? null
                        : CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                item.opponent!.profileImage!),
                          ),
                    title: Text(
                      item.content ?? "",
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(item.createdAt!.format(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary)),
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
