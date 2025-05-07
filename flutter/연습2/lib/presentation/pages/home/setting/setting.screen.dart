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
           DisplayProfileWidget(),
          ],
        ),
      ),
    );
  }
}
