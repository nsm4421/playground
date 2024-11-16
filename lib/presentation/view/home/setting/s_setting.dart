part of 'index.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: context.colorScheme.primary,
            ),
            onPressed: () {
              context.read<AuthenticationBloc>().add(SignOutEvent());
            },
          ),
        ],
        title: const Text("Setting"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [ProfileFragment()],
        ),
      ),
    );
  }
}
