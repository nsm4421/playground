part of '../../../export.pages.dart';

class CreateChatPage extends StatelessWidget {
  const CreateChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateChatCubit>(),
      child: BlocListener<CreateChatCubit, SimpleBlocState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            Timer(1.sec, () {
              context.pop();
            });
          } else if (state.status == Status.error) {
            Timer(1.sec, () {
              context
                  .read<CreateChatCubit>()
                  .updateStatus(status: Status.initial, errorMessage: '');
            });
          }
        },
        child: BlocBuilder<CreateChatCubit, SimpleBlocState>(
          builder: (context, state) {
            return LoadingOverLayWidget(
                isLoading: state.status == Status.loading ||
                    state.status == Status.success,
                child: const CreateChatScreen());
          },
        ),
      ),
    );
  }
}
