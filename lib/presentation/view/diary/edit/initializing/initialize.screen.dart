part of '../edit_diary.page.dart';

class InitializeScreen extends StatelessWidget {
  const InitializeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Initializing'),
            SizedBox(height: 15),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
