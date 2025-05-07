part of "open_chat_room.page.dart";

class PresenceListFragment extends StatelessWidget {
  const PresenceListFragment(this._presences, {super.key});

  final List<PresenceEntity> _presences;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Text("Presences",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Divider()),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final presence = _presences[index];
                  return ListTile(
                    leading: CircleAvatar(
                        radius: min(25, MediaQuery.of(context).size.width / 10),
                        backgroundImage:
                            CachedNetworkImageProvider(presence.profileImage!)),
                    title: Text(presence.nickname!),
                  );
                },
                separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Divider()),
                itemCount: _presences.length),
          ),
        ],
      ),
    );
  }
}
