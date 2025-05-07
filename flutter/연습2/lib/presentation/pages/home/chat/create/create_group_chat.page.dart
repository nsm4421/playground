part of '../../../export.pages.dart';

class CreateGroupChatPage extends StatelessWidget {
  const CreateGroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateGroupChatCubit>(),
      child: BlocListener<CreateGroupChatCubit, SimpleBlocState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            context.showSuccessSnackBar(message: 'Success');
            Timer(1.sec, () {
              context.pop();
            });
          } else if (state.status == Status.error) {
            context.showErrorSnackBar(description: state.errorMessage);
            Timer(
              1.sec,
              () {
                context
                    .read<CreateGroupChatCubit>()
                    .updateStatus(status: Status.initial, errorMessage: '');
              },
            );
          }
        },
        child: BlocBuilder<CreateGroupChatCubit, SimpleBlocState>(
          builder: (context, state) {
            return LoadingOverLayWidget(
                isLoading: state.status == Status.loading ||
                    state.status == Status.success,
                child: const CreateGroupChatScreen());
          },
        ),
      ),
    );
  }
}
