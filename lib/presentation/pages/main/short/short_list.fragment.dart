part of 'short.page.dart';

class ShortListFragment extends StatelessWidget {
  const ShortListFragment(this._shorts, {super.key});

  final List<ShortEntity> _shorts;

  @override
  Widget build(BuildContext context) {
    return _shorts.isEmpty
        ? const _OnEmpty()
        : ListView.builder(
            itemCount: _shorts.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ShortItemWidget(_shorts[index]);
            });
  }
}

class _OnEmpty extends StatelessWidget {
  const _OnEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("NO VIDEO FOUNDED",
          style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
