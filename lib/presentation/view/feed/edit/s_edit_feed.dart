part of 'page.dart';

class EditFeedScreen extends StatelessWidget {
  const EditFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              /// Assets
              Padding(
                  padding: EdgeInsets.only(left: 12, top: 60),
                  child: DisplayAvatarFragment(120)),

              /// 본문
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12, top: 30),
                child: EditorContentFragment(),
              ),

              /// 해시태그
              Padding(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 30),
                  child: EditorHashtagFragment())
            ]))),
        floatingActionButton: FabWidget());
  }
}
