part of '../page.dart';

class AccompanyScreen extends StatelessWidget {
  const AccompanyScreen(this._meeting, {super.key});

  final MeetingEntity _meeting;

  @override
  Widget build(BuildContext context) {
    final currentUid =
        context.read<AuthenticationBloc>().state.currentUser!.uid;
    final isManager = _meeting.author!.uid == currentUid;
    return BlocBuilder<DisplayRegistrationBloc,
        CustomDisplayState<RegistrationEntity>>(builder: (context, state) {
      final isRegistered =
          state.data.map((item) => item.proposer!.uid).contains(currentUid);
      return Scaffold(
          body: BlocBuilder<DisplayRegistrationBloc,
                  CustomDisplayState<RegistrationEntity>>(
              builder: (context, state) {
            return LoadingOverLayScreen(
                isLoading: state.isFetching,
                loadingWidget: const Center(child: CircularProgressIndicator()),
                childWidget: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final item = state.data[index];
                      final isMine = item.proposer?.uid ==
                          context
                              .read<AuthenticationBloc>()
                              .state
                              .currentUser
                              ?.uid;
                      return isManager
                          ? ManagerRegistrationWidget(
                          registration: item, isMine: isMine)
                          : ProposerRegistrationItemWidget(
                          registration: item, isMine: isMine);
                    }));
          }),
          bottomNavigationBar: (isRegistered || isManager)
              ? null
              : const EditAccompanyFragment());
    });
  }
}
