part of 'index.dart';

class FeedCommentScreen extends StatelessWidget {
  const FeedCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const FeedCommentListFragment(),
        bottomNavigationBar: const EditCommentWidget(),
      ),
    );
  }
}
