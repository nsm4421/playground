part of 'create_media.page.dart';

class UnAuthorizedScreen extends StatefulWidget {
  const UnAuthorizedScreen({super.key});

  @override
  State<UnAuthorizedScreen> createState() => _UnAuthorizedScreenState();
}

class _UnAuthorizedScreenState extends State<UnAuthorizedScreen> {
  _askPermission() async {
    await context.read<CreateMediaCubit>().askPermission();
  }

  _openSetting() async {
    await PhotoManager.openSetting();
  }

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
              onPressed: _askPermission, child: const Text('권한 요청하기')),
          ElevatedButton(onPressed: _openSetting, child: const Text('세팅 열기'))
        ],
      ),
    );
  }
}
