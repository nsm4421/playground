part of '../export.pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                context.push(Routes.chat.path);
              },
              icon: Icon(Icons.chat))
        ],
      ),
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutEvent());
              },
              icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () {
                context.push(Routes.createFeed.path);
              },
              icon: Icon(Icons.create))
        ],
      ),
    );
  }
}
