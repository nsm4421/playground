part of 'page.dart';

class DisplayAccompanyScreen extends StatefulWidget {
  const DisplayAccompanyScreen(this.registrations, {super.key});

  final List<RegistrationEntity> registrations;

  @override
  State<DisplayAccompanyScreen> createState() => _DisplayAccompanyScreenState();
}

class _DisplayAccompanyScreenState extends State<DisplayAccompanyScreen> {
  static const _maxLength = 30;
  late TextEditingController _tec;

  @override
  initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handleJoin() async {
    final text = _tec.text.trim();
    if (text.isEmpty) return;
    log('join request');
    context
        .read<EditRegistrationBloc>()
        .add(RegisterMeetingEvent(introduce: text));
  }

  @override
  Widget build(BuildContext context) {
    final currentUid =
        context.read<AuthenticationBloc>().state.currentUser!.uid;
    final isRegistered = widget.registrations
        .map((item) => item.proposer!.uid)
        .contains(currentUid);
    return Scaffold(
        body: Column(children: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Divider()),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.registrations.length,
              itemBuilder: (context, index) {
                final item = widget.registrations[index];
                return RegistrationItemWidget(item);
              })
        ]),
        bottomNavigationBar: isRegistered
            ? null
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: _tec,
                    maxLines: 1,
                    maxLength: _maxLength,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: _handleJoin,
                            icon: const Icon(Icons.check)),
                        hintText: 'hi~! go travel together',
                        helperText: 'join group'))));
  }
}

class RegistrationItemWidget extends StatelessWidget {
  const RegistrationItemWidget(this.registration, {super.key});

  final RegistrationEntity registration;

  @override
  Widget build(BuildContext context) {
    final isManager = registration.proposer?.uid == registration.manager?.uid;
    if (isManager) {
      return ListTile(
          leading: CircularAvatarWidget(registration.manager!.avatarUrl),
          title: Text('Manager',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary)),
          subtitle: Text(registration.manager!.username),
          trailing:
              Icon(Icons.star, color: Theme.of(context).colorScheme.primary));
    } else {
      return ListTile(
          leading: CircularAvatarWidget(registration.proposer!.avatarUrl),
          title: Text(registration.introduce ?? '',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall),
          subtitle: Text(registration.proposer!.username),
          trailing:
              registration.isPermitted! ? const Icon(Icons.done_all) : null);
    }
  }
}
