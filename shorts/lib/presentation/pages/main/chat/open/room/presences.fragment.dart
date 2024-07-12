part of 'open_chat_room.page.dart';

class PresencesFragment extends StatelessWidget {
  const PresencesFragment(this._presences, {super.key});

  final List<PresenceEntity> _presences;

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>().state as UserLoadedState;
    final currentUser = userState.account;
    final presences = _presences.where((p) => p.uid != currentUser.id).toList();
    return SingleChildScrollView(
        child: SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          children: [
            ListTile(
                leading: AvatarWidget(currentUser.profileUrl!),
                title: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: currentUser.nickname,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800))
                ])),
                subtitle: const Text("ME")),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Divider()),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: presences.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = presences[index];
                  return ListTile(
                    leading: AvatarWidget(item.profileUrl),
                    title: Text(item.nickname ?? ''),
                    subtitle: Text(TimeUtil.timeAgo(item.onlineAt!)),
                  );
                }),
          ],
        ),
      ),
    ));
  }
}
