part of '../edit_diary.page.dart';

class InitializeScreen extends StatefulWidget {
  const InitializeScreen({super.key});

  @override
  State<InitializeScreen> createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  static const int _loadingDuration = 500;

  @override
  void initState() {
    super.initState();
    // 0.5초동안 로딩화면 보여주기
    Timer(const Duration(milliseconds: _loadingDuration), () {
      context.read<EditDiaryBloc>().add(LoadDiaryEvent());
    });
  }

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
