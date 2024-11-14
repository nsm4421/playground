part of 'index.dart';

class ReelsListFragment extends StatefulWidget {
  const ReelsListFragment(this.reels, {super.key});

  final List<ReelsEntity> reels;

  @override
  State<ReelsListFragment> createState() => _ReelsListFragmentState();
}

class _ReelsListFragmentState extends State<ReelsListFragment> {

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.reels.length,
      itemBuilder: (context, index) {
        return ReelsItemWidget(widget.reels[index]);
      },
    );
  }
}
