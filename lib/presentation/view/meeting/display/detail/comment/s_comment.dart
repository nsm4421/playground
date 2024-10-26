part of '../page.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: DisplayCommentFragment(),
        bottomNavigationBar:
            Padding(padding: EdgeInsets.all(8.0), child: EditCommentWidget()));
  }
}
