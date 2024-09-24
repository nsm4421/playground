part of 'setting.page.dart';

class UserProfileFragment extends StatefulWidget {
  const UserProfileFragment({super.key});

  @override
  State<UserProfileFragment> createState() => _UserProfileFragmentState();
}

class _UserProfileFragmentState extends State<UserProfileFragment> {
  _moveEditProfile() {
    context.push(RoutePaths.editProfile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeight.sm,

        /// 현재 로그인한 유저정보
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          final presence = context.read<AuthenticationBloc>().presence;
          return ListTile(
            leading: CircularAvatarImageWidget(presence.avatarUrl!),
            title: Text(presence.username!),
            trailing: IconButton(
              onPressed: _moveEditProfile,
              icon: Icon(Icons.edit,
                  size: CustomTextSize.xl,
                  color: Theme.of(context).colorScheme.primary),
            ),
          );
        }),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: CustomSpacing.md),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.feed),
                      Text("FEED"),
                    ],
                  ),
                  Text("32"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: CustomSpacing.md),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.feed),
                      Text("FEED"),
                    ],
                  ),
                  Text("32"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: CustomSpacing.md),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.feed),
                      Text("FEED"),
                    ],
                  ),
                  Text("32"),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
