part of 'page.dart';

class AccompanyFragment extends StatefulWidget {
  const AccompanyFragment(
      {super.key, required this.entity, required this.accompanies});

  final MeetingEntity entity;
  final List<PresenceEntity> accompanies;

  @override
  State<AccompanyFragment> createState() => _AccompanyFragmentState();
}

class _AccompanyFragmentState extends State<AccompanyFragment> {
  static const double _avatarSize = 100;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(children: [
        Row(children: [
          const Icon(Icons.people_alt_outlined, size: 30),
          const SizedBox(width: 12),
          Text('Accompany',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.tertiary)),
          const Spacer(),
          Text('${widget.accompanies.length}/${widget.entity.headCount}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700))
        ]),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: _avatarSize + 10,
            child: ListView.builder(
                padding: const EdgeInsets.only(right: 8, top: 12, bottom: 12),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.accompanies.length,
                itemBuilder: (context, index) {
                  return CircularAvatarWidget(
                      size: _avatarSize, widget.accompanies[index].avatarUrl);
                }))
      ]),
    );
  }
}
