part of 'index.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ListTile(
          leading: CachedCircularImageWidget(state.currentUser!.avatarUrl),
          title: Text(
            state.currentUser!.username,
            style: context.textTheme.titleMedium,
          ),
          trailing: IconButton(
            onPressed: () async {
              // 프로필 수정 페이지로
              context.read<HomeBottomNavCubit>().switchVisible(false);
              await context.push(Routes.editProfile.path).whenComplete(() {
                context.read<HomeBottomNavCubit>().switchVisible(true);
              });
            },
            icon: Icon(
              Icons.edit,
              color: context.colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
