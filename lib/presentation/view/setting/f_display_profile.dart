part of 'page.dart';

class DisplayProfileFragment extends StatelessWidget {
  const DisplayProfileFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return ListTile(
          leading: RoundedAvatarWidget(
              width: 50,
              height: 50,
              state.currentUser!.avatarUrl,
              fit: BoxFit.cover),
          title: Text(state.currentUser?.username ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          trailing: IconButton(
              onPressed: () {
                context.push(Routes.editProfile.path);
              },
              icon: const Icon(Icons.edit)));
    });
  }
}
