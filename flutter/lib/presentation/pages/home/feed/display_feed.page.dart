part of '../../export.pages.dart';

class DisplayFeedPage extends StatelessWidget{
  const DisplayFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DisplayFeedBloc>()..add(MountEvent()),
      child: BlocListener<DisplayFeedBloc, DisplayState<FeedEntity>>(
        listener: (context, state) async {
          if (state.status == Status.error) {
            context.showErrorSnackBar(description: state.message);
            Timer(1.sec, () {
              context
                  .read<DisplayFeedBloc>()
                  .add(InitDisplayEvent(status: Status.initial, message: ''));
            });
          }
        },
        child: BlocBuilder<DisplayFeedBloc, DisplayState<FeedEntity>>(
          builder: (context, state) {
            return LoadingOverLayWidget(
                isLoading: !state.isMounted || state.status == Status.loading,
                child: const DisplayFeedScreen());
          },
        ),
      ),
    );
  }
}
