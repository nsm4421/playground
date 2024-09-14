part of 'create_feed.page.dart';

class SelectDirectoryFragment extends StatelessWidget {
  const SelectDirectoryFragment(this._album, {super.key});

  final List<AssetPathEntity> _album;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _album.length,
      itemBuilder: (context, index) {
        final item = _album[index];
        return ListTile(
          onTap: () {
            // 선택한 디렉터리 경로를 원래 페이지로 전달하기
            context.pop(item);
          },
          title: Text(item.name, style: Theme.of(context).textTheme.titleLarge),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Padding(
        padding: EdgeInsets.symmetric(vertical: CustomSpacing.tiny),
        child: Divider(indent: CustomSpacing.md, endIndent: CustomSpacing.md),
      ),
    );
  }
}
