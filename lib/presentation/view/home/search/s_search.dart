part of 'index.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 텍스트 필드 버튼
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 8, right: 8),
              child: TextField(
                readOnly: true,
                // 버튼을 누르는 경우 검색옵션을 선택할 수 있는 페이지로 이동
                onTap: () async {
                  context.read<HomeBottomNavCubit>().switchVisible(false);
                  await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const SearchOptionWidget();
                      }).then((res) {
                    // TODO : 검색옵션이 변경된 경우 게시글 다시 가져오기
                  }).whenComplete(
                    () {
                      context.read<HomeBottomNavCubit>().switchVisible(true);
                    },
                  );
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search',
                ),
              ),
            ),
            // TODO : 현재 선택된 검색옵션 표시

            // TODO : 검색결과 표시
            SearchedFragment()
          ],
        ),
      ),
    );
  }
}
