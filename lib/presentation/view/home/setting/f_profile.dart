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
            onPressed: () {
              // TODO : 프로필 수정
            },
            icon: Icon(Icons.edit),
          ),
        );
      },
    );
  }
}
