part of '../page.dart';

class ManagerRegistrationWidget extends StatefulWidget {
  const ManagerRegistrationWidget(
      {super.key, required this.registration, required this.isMine});

  final RegistrationEntity registration;
  final bool isMine;

  @override
  State<ManagerRegistrationWidget> createState() =>
      _ManagerRegistrationWidgetState();
}

class _ManagerRegistrationWidgetState extends State<ManagerRegistrationWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditRegistrationBloc, EditRegistrationState>(
      builder: (context, state) {
        return ListTile(
            leading:
                CircularAvatarWidget(widget.registration.proposer!.avatarUrl),
            title: Text(widget.registration.introduce ?? '',
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary)),
            subtitle: Text(widget.registration.proposer?.username ?? ''),
            trailing: widget.isMine
                ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary)
                : IconButton(
                    onPressed: () {
                      if (!state.status.ok) {
                        return;
                      } else if (widget.registration.isPermitted) {
                        log('cancel permit button clicked');
                        context.read<EditRegistrationBloc>().add(
                            CancelPermitRegistrationEvent(
                                widget.registration.id!));
                        context.read<DisplayRegistrationBloc>().add(
                            InitDisplayEvent<RegistrationEntity>(
                                data: context
                                    .read<DisplayRegistrationBloc>()
                                    .state
                                    .data
                                    .map((item) =>
                                        item.id == widget.registration.id
                                            ? item.copyWith(isPermitted: false)
                                            : item)
                                    .toList()));
                      } else {
                        log('permit button clicked');
                        context.read<EditRegistrationBloc>().add(
                            PermitRegistrationEvent(widget.registration.id!));
                        context.read<DisplayRegistrationBloc>().add(
                            InitDisplayEvent<RegistrationEntity>(
                                data: context
                                    .read<DisplayRegistrationBloc>()
                                    .state
                                    .data
                                    .map((item) =>
                                        item.id == widget.registration.id
                                            ? item.copyWith(isPermitted: true)
                                            : item)
                                    .toList()));
                      }
                    },
                    icon: Icon(
                        widget.registration.isPermitted
                            ? Icons.cancel_outlined
                            : Icons.add_box_outlined,
                        color: Theme.of(context).colorScheme.secondary),
                  ));
      },
    );
  }
}
