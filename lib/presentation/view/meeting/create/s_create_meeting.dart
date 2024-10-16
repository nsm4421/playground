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
            child: Column(children: [
          /// country
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: SelectCountryFragment()),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: SelectDateFragment()),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: SelectPreferenceFragment()),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: SelectBudgetFragment()),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: DetailFragment()),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: HashtagFragment()),
                    Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: SelectThumbnailFragment())
                  ]))
        ])));
  }
}
