part of '../../export.pages.dart';

class DisplayGroupChatPage extends StatelessWidget {
  const DisplayGroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DisplayGroupChatBloc>()..add(MountEvent()),
      child: BlocListener<DisplayGroupChatBloc, DisplayState<GroupChatEntity>>(
        listener: (context, state) async {
          if (state.status == Status.error) {
            context.showErrorSnackBar(description: state.message);
            Timer(1.sec, () {
              context
                  .read<DisplayGroupChatBloc>()
                  .add(InitDisplayEvent(status: Status.initial, message: ''));
            });
          }
        },
        child: BlocBuilder<DisplayGroupChatBloc, DisplayState<GroupChatEntity>>(
          builder: (context, state) {
            return LoadingOverLayWidget(
                isLoading: !state.isMounted || state.status == Status.loading,
                child: const DisplayGroupChatScreen());
          },
        ),
      ),
    );
  }
}
