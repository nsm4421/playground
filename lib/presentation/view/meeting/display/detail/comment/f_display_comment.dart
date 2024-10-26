part of '../page.dart';

class DisplayCommentFragment extends StatelessWidget {
  const DisplayCommentFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DisplayCommentBloc<MeetingEntity>,
        CustomDisplayState<CommentEntity>>(listener: (context, state) {
      if (state.status == Status.error) {
        customUtil.showErrorSnackBar(
            context: context, message: state.errorMessage);
        Timer(const Duration(seconds: 1), () {
          context
              .read<DisplayCommentBloc<MeetingEntity>>()
              .add(InitDisplayEvent(status: Status.initial));
        });
      }
    }, child: BlocBuilder<DisplayCommentBloc<MeetingEntity>,
        CustomDisplayState<CommentEntity>>(builder: (context, state) {
      return LoadingOverLayScreen(
          isLoading: state.isFetching,
          childWidget: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = state.data[index];
                return ListTile(
                    leading: CircularAvatarWidget(item.author!.avatarUrl),
                    title: ExpandableTextWidget(item.content ?? ''),
                    subtitle: Text(customUtil
                        .timeAgoInKr(item.createdAt!.toIso8601String())));
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: state.data.length));
    }));
  }
}
