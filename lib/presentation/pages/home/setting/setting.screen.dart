part of '../../export.pages.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthBloc>().state.user!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutEvent());
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCircleAvatarWidget(currentUser.profileImage),
                  (16.width),
                  Text(
                    currentUser.username,
                    style: context.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
