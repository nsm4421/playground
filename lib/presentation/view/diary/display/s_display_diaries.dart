part of 'page.dart';

class DisplayDiariesScreen extends StatefulWidget {
  const DisplayDiariesScreen(this._diaries, {super.key});

  final List<DiaryEntity> _diaries;

  @override
  State<DisplayDiariesScreen> createState() => _DisplayDiariesScreenState();
}

class _DisplayDiariesScreenState extends State<DisplayDiariesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DisplayDiaryAppBarWidget(),
        body: RefreshIndicator(
          onRefresh: () async {
            context
                .read<DisplayDiaryBloc>()
                .add(FetchDiariesEvent(refresh: true));
          },
          child: SingleChildScrollView(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget._diaries.length,
                itemBuilder: (context, index) {
                  return DiaryItemWidget(widget._diaries[index]);
                }),
          ),
        ));
  }
}
