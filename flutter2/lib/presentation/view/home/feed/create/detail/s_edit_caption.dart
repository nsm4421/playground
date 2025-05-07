part of '../index.dart';

class EditDetailScreen extends StatefulWidget {
  const EditDetailScreen({super.key, required this.handleJumpPage});

  final void Function() handleJumpPage;

  @override
  State<EditDetailScreen> createState() => _EditDetailScreenState();
}

class _EditDetailScreenState extends State<EditDetailScreen> {
  late TextEditingController _textController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              widget.handleJumpPage();
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
              padding: EdgeInsets.only(left: 12, right: 12, top: 20),
              child: HashtagFragment(),
            )
          ],
        ),
      ),
    );
  }
}
