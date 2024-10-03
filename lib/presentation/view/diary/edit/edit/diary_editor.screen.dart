part of '../edit_diary.page.dart';

class DiaryEditorScreen extends StatelessWidget {
  const DiaryEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: EditorAppBar(),
      body: Column(children: [
        EditorHeaderFragment(),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
            child: Divider()),
        Expanded(child: EditorBody()),
      ]),
      floatingActionButton: FabWidget(),
    );
  }
}
