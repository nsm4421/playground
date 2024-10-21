part of 'page.dart';

class AccompanyListFragment extends StatelessWidget {
  const AccompanyListFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUid =
        context.read<AuthenticationBloc>().state.currentUser!.uid;
    final mangerUid = context.read<EditRegistrationBloc>().meeting.id;

    return BlocBuilder<EditRegistrationBloc, EditRegistrationState>(
        builder: (context, state) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: state.registrations.length,
          itemBuilder: (context, index) {
            final item = state.registrations[index];
            return ListTile(
                leading: CircularAvatarWidget(item.proposer!.avatarUrl),
                title: Text(item.introduce ?? '',
                    softWrap: true, overflow: TextOverflow.ellipsis),
                subtitle: Text(item.proposer!.username),
                trailing: IconButton(
                    // TODO : 탭했을 때 이벤트
                    onPressed: () {
                      if (currentUid == mangerUid){
                        // ~~~~~
                      }
                    },
                    icon: item.isPermitted!
                        ? const Icon(Icons.check_box_outlined)
                        : const Icon(Icons.check_box_outline_blank_rounded)));
          });
    });
  }
}
