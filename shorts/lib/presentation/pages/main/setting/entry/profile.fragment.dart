part of 'setting.page.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  late AccountEntity _account;

  @override
  void initState() {
    super.initState();
    _account = (context.read<UserBloc>().state as UserLoadedState).account;
  }

  _handleGoToEditPage() {
    context.push(Routes.editProfile.path);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_account.nickname ?? '',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800)),
      subtitle: Text(_account.description ?? '',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              overflow: TextOverflow.ellipsis)),
      leading: AvatarWidget(_account.profileUrl!),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: _handleGoToEditPage,
      ),
    );
  }
}
