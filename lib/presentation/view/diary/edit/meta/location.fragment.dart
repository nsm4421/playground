part of '../edit_diary.page.dart';

class LocationFragment extends StatelessWidget {
  const LocationFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('현재 위치를 불러오시겠습니까?',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary)),
              const Spacer(),
              ElevatedButton(

                  /// TODO : 위치 불러오기 기능 추가하기
                  onPressed: () {},
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text('Location',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith())
                  ]))
            ],
          ),
        ],
      ),
    );
  }
}
