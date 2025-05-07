part of 'index.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 텍스트 필드 버튼
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, left: 8, right: 8),
            child: const NavigateToOptionWidget(),
          ),
          const Expanded(child: SearchedFragment())
        ],
      ),
    );
  }
}
