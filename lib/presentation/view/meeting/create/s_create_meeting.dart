part of 'page.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({super.key});

  @override
  State<CreateMeetingScreen> createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Meeting'),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<CreateMeetingCubit>().submit();
                },
                icon: Icon(Icons.check,
                    size: 25, color: Theme.of(context).colorScheme.primary))
          ],
        ),
        body: const SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /// 여행할 국가 선택
            SelectCountryFragment(),
            Padding(padding: EdgeInsets.all(16), child: Divider()),

            /// 여행일자 선택
            SelectDateFragment(),
            Padding(padding: EdgeInsets.all(16), child: Divider()),

            /// 같이갈 동행
            SelectPreferenceFragment(),
            Padding(padding: EdgeInsets.all(16), child: Divider()),

            /// 세부 내용
            DetailFragment(),
            SizedBox(height: 12),
            HashtagFragment(),
            SizedBox(height: 12),
            SelectThumbnailFragment(),
            Padding(padding: EdgeInsets.all(16), child: Divider()),
          ]),
        )));
  }
}
