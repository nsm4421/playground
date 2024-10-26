part of '../page.dart';

class ProposerRegistrationItemWidget extends StatelessWidget {
  const ProposerRegistrationItemWidget(
      {super.key, required this.registration, required this.isMine});

  final RegistrationEntity registration;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final color = registration.isPermitted
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.tertiary;

    return BlocBuilder<EditRegistrationBloc, EditRegistrationState>(
        builder: (context, state) {
      return ListTile(
          leading: CircularAvatarWidget(registration.proposer!.avatarUrl),
          title: Text(registration.introduce ?? '',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium),
          subtitle: Row(
            children: [
              Icon(
                  registration.isPermitted
                      ? Icons.done_all
                      : Icons.not_interested,
                  color: color),
              const SizedBox(width: 8),
              Text(registration.proposer?.username ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: color)),
            ],
          ),
          trailing: isMine
              ? IconButton(
                  tooltip: 'cancel registration',
                  onPressed: () {
                    if (state.status.ok) {
                      // 동행 요청 삭제 요청
                      context
                          .read<EditRegistrationBloc>()
                          .add(DeleteRegistrationEvent());
                      // 동행 요청 목록 업데이트
                      context.read<DisplayRegistrationBloc>().add(
                          InitDisplayEvent<RegistrationEntity>(
                              data: context
                                  .read<DisplayRegistrationBloc>()
                                  .state
                                  .data
                                  .where((item) => item.id != registration.id)
                                  .toList()));
                    }
                  },
                  icon: const Icon(Icons.login_outlined))
              : null);
    });
  }
}
