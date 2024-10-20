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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          ])),

      /// 여행할 국가
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IconLabelWidget(iconData: Icons.flag, label: entity.country!)),

      /// 여행기간
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IconLabelWidget(
              iconData: Icons.calendar_today,
              label: '${entity.dateRangeRepr}(${entity.durationInDay}days)')),

      /// 성별
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IconLabelWidget(
              iconData: Icons.male, label: '${entity.sex?.label}')),

      /// 여행 테마
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IconLabelWidget(
              iconData: Icons.travel_explore, label: '${entity.theme?.label}')),

      /// 예산
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IconLabelWidget(
              iconData: Icons.money,
              label: '${entity.minCost}~${entity.maxCost}만원'))
    ]);
  }
}
