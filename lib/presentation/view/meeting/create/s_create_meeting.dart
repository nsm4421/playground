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
      appBar: AppBar(title: const Text('Create Meeting')),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            /// country
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: SelectCountryFragment(),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: SelectDateFragment(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
