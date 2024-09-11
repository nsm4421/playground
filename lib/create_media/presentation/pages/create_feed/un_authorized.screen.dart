part of 'create_feed.page.dart';

class UnAuthorizedScreen extends StatelessWidget {
  const UnAuthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '디바이스 내 사진에 접근권한이 거부되었습니다',
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          ElevatedButton(
              onPressed: () async {
                await context.read<CreateFeedCubit>().askPermission();
              },
              child: const Text('권한 허용하기'))
        ],
      ),
    );
  }
}
