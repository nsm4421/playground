part of 'feed.page.dart';

class FetchMoreFeedButtonWidget extends StatelessWidget {
  const FetchMoreFeedButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<DisplayFeedBloc, DisplayFeedState>(
          builder: (context, state) {
        if (context.read<DisplayFeedBloc>().isEnd) {
          return const Text("마지막 페이지 입니다");
        } else if (state is DisplayFeedLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is InitialDisplayFeedState ||
            state is DisplayFeedSuccessState) {
          return ElevatedButton(
              onPressed: () {
                context.read<DisplayFeedBloc>().add(FetchDisplayFeedEvent());
              },
              child: const Text("더 가져오기"));
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
