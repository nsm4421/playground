part of 'index.dart';

class UnAuthorizedScreen extends StatelessWidget {
  const UnAuthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("UNAUTHORIZED")),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                context.read<CreateFeedBloc>().add(AskPermissionEvent());
              },
              child: const Text("Permit"))
        ],
      ),
    );
  }
}
