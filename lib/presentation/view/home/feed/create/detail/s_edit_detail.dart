part of '../index.dart';

class EditDetailScreen extends StatelessWidget {
  const EditDetailScreen({super.key, required this.handleJumpPage});

  final void Function() handleJumpPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              handleJumpPage();
            },
            icon: const Icon(Icons.chevron_left)),
        actions: [
          InkWell(
            onTap: () async {
              FocusScope.of(context).unfocus();
              await Future.delayed(200.ms, () {
                context.read<CreateFeedBloc>().add(SubmitEvent());
              });
            },
            child: Text(
              "Upload",
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CarouselFragment(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ContentFragment()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: HashtagFragment(),
            )
          ],
        ),
      ),
    );
  }
}
