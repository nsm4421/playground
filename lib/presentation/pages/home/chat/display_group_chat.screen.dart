part of '../../export.pages.dart';

class DisplayGroupChatScreen extends StatefulWidget {
  const DisplayGroupChatScreen({super.key});

  @override
  State<DisplayGroupChatScreen> createState() => _DisplayGroupChatScreenState();
}

class _DisplayGroupChatScreenState extends State<DisplayGroupChatScreen> {
  _handleRoute(GroupChatEntity chat) => () async {
        await context.push(Routes.groupChatRoom.path, extra: chat);
      };

  _handleTapMoreIcon() async {
    // TODO : 채팅창 수정 UI 구현하기
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    final currentUid = context.read<AuthBloc>().state.user?.id;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Chats"),
        actions: [
          IconButton(
              onPressed: () {
                context.push(Routes.createGroupChat.path);
              },
              icon: const Icon(Icons.add_circle_outline))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<DisplayGroupChatBloc>().add(MountEvent());
        },
        child: BlocBuilder<DisplayGroupChatBloc, DisplayState<GroupChatEntity>>(
          builder: (context, state) {
            return ListView.separated(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final item = state.data[index];
                final isMine = item.author.id == currentUid;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: _handleRoute(item),
                      child: ListTile(
                        leading: CustomCircleAvatarWidget(item.author.profileImage),
                        title: Text(
                          item.title,
                          style: context.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          item.author.username,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        trailing: isMine
                            ? IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: _handleTapMoreIcon,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                    if (item.hashtags.isNotEmpty)
                      HashtagListWidget(hashtags: item.hashtags)
                  ],
                );
              },
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Divider(),
              ),
            );
          },
        ),
      ),
    );
  }
}
