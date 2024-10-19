part of 'page.dart';

class MeetingItemsFragment extends StatelessWidget {
  const MeetingItemsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayMeetingBloc, CustomDisplayState<MeetingEntity>>(
        builder: (context, state) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: state.data.length,
          itemBuilder: (context, index) {
            return MeetingItemWidget(state.data[index]);
          });
    });
  }
}
