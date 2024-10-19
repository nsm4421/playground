part of 'page.dart';

class DescriptionFragment extends StatelessWidget {
  const DescriptionFragment(this.entity, {super.key});

  final MeetingEntity entity;
  static const double _iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      /// 본문
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Column(
          children: [
            Row(children: [
              Icon(Icons.abc,
                  size: _iconSize,
                  color: Theme.of(context).colorScheme.tertiary),
              const SizedBox(width: 8),
              Text('Content',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.tertiary))
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(entity.content ?? '',
                  style: Theme.of(context).textTheme.titleMedium),
            )
          ],
        ),
      ),

      /// 여행할 국가
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: _Grid(iconData: Icons.flag, text: entity.country!),
      ),

      /// 여행기간
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: _Grid(
            iconData: Icons.calendar_today,
            text: '${entity.dateRangeRepr}(${entity.durationInDay}days)'),
      ),

      /// 성별
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: _Grid(iconData: Icons.male, text: '${entity.sex?.name}'),
      ),

      /// 여행 테마
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: _Grid(
            iconData: Icons.travel_explore, text: '${entity.theme?.label}'),
      ),

      /// 예산
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _Grid(
              iconData: Icons.money,
              text: '${entity.minCost}~${entity.maxCost}만원'))
    ]);
  }
}

class _Grid extends StatelessWidget {
  const _Grid({super.key, required this.iconData, required this.text});

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
          width: 50,
          child: Icon(iconData,
              size: 30, color: Theme.of(context).colorScheme.tertiary)),
      const SizedBox(width: 12),
      Text(text,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w500))
    ]);
  }
}
