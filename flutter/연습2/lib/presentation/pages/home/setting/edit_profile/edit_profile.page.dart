part of '../../../export.pages.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<EditProfileCubit>(param1: context.read<AuthBloc>().state.user),
      child: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            context.showErrorSnackBar(
                message: 'Error Occur', description: state.errorMessage);
            Timer(1.sec, () {
              context
                  .read<EditProfileCubit>()
                  .update(status: Status.initial, errorMessage: '');
            });
          } else if (state.status == Status.success) {
            context
              ..showSuccessSnackBar(
                  message: 'Success', description: 'Profile Edited')
              ..read<AuthBloc>().add(GetUserEvent());
            Timer(1.sec, () {
              context.pop();
            });
          }
        },
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            return LoadingOverLayWidget(
                isLoading: state.status != Status.initial,
                child: const EditProfileScreen());
          },
        ),
      ),
    );
  }
}
