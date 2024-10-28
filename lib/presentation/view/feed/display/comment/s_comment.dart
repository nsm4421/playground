part of 'page.dart';

class FeedCommentScreen extends StatelessWidget {
  const FeedCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// 헤더
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: Row(children: [
                Text('Comments',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.clear))
              ])),

          /// 댓글목록
          const Expanded(child: CommentListFragment())
        ]),

        /// 댓글 입력창
        bottomNavigationBar: const EditCommentFragment());
  }
}
