part of 'home.page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(SignOutEvent());
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
