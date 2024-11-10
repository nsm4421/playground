part of 'index.dart';

class CreateMediaScreen extends StatefulWidget {
  const CreateMediaScreen({super.key});

  @override
  State<CreateMediaScreen> createState() => _CreateMediaScreenState();
}

class _CreateMediaScreenState extends State<CreateMediaScreen> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handleJumpToDetailPage() async {
    final isAssetSelected =
        context.read<CreateFeedBloc>().state.images.isNotEmpty;
    if (isAssetSelected) {
      log('to next page');
      await _controller.animateToPage(1,
          duration: 200.ms, curve: Curves.easeInOut);
    } else {
      getIt<CustomSnackBar>().error(title: 'picture is not selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return index == 0
            ? SelectMediaScreen(handleJumpPage: _handleJumpToDetailPage)
            : const EditDetailScreen();
      },
    );
  }
}
