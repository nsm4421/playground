part of '../../../export.pages.dart';

class CreateFeedPage extends StatelessWidget {
  const CreateFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                getIt<SelectMediaCubit>(param1: RequestType.image)..onInit()),
        BlocProvider(create: (_) => getIt<CreateFeedCubit>()),
      ],
      child: BlocBuilder<SelectMediaCubit, SelectMediaState>(
          builder: (context, state) {
        if (!state.isAuth) {
          return Text("Permission Denied",
              style: context.textTheme.displayLarge);
        } else if (!state.mounted && state.status != Status.error) {
          return const Center(child: CircularProgressIndicator());
        } else if (!state.mounted && state.status == Status.error) {
          return Text(state.errorMessage,
              style: context.textTheme.displayLarge);
        }
        return BlocListener<CreateFeedCubit, EditFeedState>(
          listener: (context, state) {
            if (state.status == Status.error) {
              Timer(1.sec, () {
                context
                    .read<CreateFeedCubit>()
                    .initState(status: Status.initial, errorMessage: '');
              });
            } else if (state.status == Status.success) {
              Timer(1.sec, () {
                context.pop();
              });
            }
          },
          child: BlocBuilder<CreateFeedCubit, EditFeedState>(
            builder: (context, state) {
              return LoadingOverLayWidget(
                  isLoading: state.status == Status.loading ||
                      state.status == Status.success,
                  loadingWidget:
                      const Center(child: CircularProgressIndicator()),
                  child: const CreateFeedScreen());
            },
          ),
        );
      }),
    );
  }
}
