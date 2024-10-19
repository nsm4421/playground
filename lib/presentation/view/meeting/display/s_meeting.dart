part of 'page.dart';

class DisplayMeetingScreen extends StatelessWidget {
  const DisplayMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              context.push(Routes.createMeeting.path);
            },
            icon: const Icon(Icons.edit),
            tooltip: 'Write Article')
      ]),
      body: Scaffold(
          body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<DisplayMeetingBloc>()
              .add(FetchMeetingEvent(refresh: true));
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: MeetingItemsFragment(),
        ),
      )),
    );
  }
}
