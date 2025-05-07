part of '../../../export.pages.dart';

class FeedCommentPage extends StatelessWidget {
  const FeedCommentPage(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) =>
              getIt<DisplayFeedCommentBloc>(param1: _feed)..add(MountEvent())),
      BlocProvider(create: (_) => getIt<CreateFeedCommentCubit>(param1: _feed))
    ], child: const FeedCommentScreen());
  }
}
