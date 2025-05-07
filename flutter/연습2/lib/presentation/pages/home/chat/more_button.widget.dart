part of '../../export.pages.dart';

class ChatMoreButtonWidget extends StatelessWidget {
  const ChatMoreButtonWidget(this._chat, {super.key});

  final GroupChatEntity _chat;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          context.read<HomeBottomNavCubit>().handleVisibility(false);
          await showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (modalCtx) {
                return Column(
                  children: [
                    // 삭제 버튼
                    ListTile(
                      onTap: () {
                        context.read<DisplayGroupChatBloc>().add(
                            DeleteDisplayDataEvent<GroupChatEntity>(_chat));
                        if (modalCtx.canPop()) modalCtx.pop();
                      },
                      leading: const Icon(Icons.delete_forever),
                      title: const Text("Delete Group Chat"),
                    ),
                  ],
                );
              }).whenComplete(() {
            context.read<HomeBottomNavCubit>().handleVisibility(true);
          });
        },
        icon: const Icon(Icons.more_vert));
  }
}
