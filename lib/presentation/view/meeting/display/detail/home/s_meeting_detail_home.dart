part of '../page.dart';

class MeetingDetailHomeScreen extends StatelessWidget {
  const MeetingDetailHomeScreen(this._meeting, {super.key});

  final MeetingEntity _meeting;

  static const double _iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      /// 썸네일
      if (_meeting.thumbnail != null)
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Row(children: [
                Icon(Icons.photo,
                    size: _iconSize,
                    color: Theme.of(context).colorScheme.tertiary),
                const SizedBox(width: 8),
                Text('Thumbnail',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary))
              ]),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.5),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image:
                            CachedNetworkImageProvider(_meeting.thumbnail!)))),
          ],
        ),

      /// 제목
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(Icons.title,
                  size: _iconSize,
                  color: Theme.of(context).colorScheme.tertiary),
              const SizedBox(width: 8),
              Text('Title',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.tertiary))
            ]),
            Padding(
                padding: const EdgeInsets.all(12),
                child: Card(
                    elevation: 1,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(_meeting.title ?? '',
                            style: Theme.of(context).textTheme.titleLarge))))
          ])),

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
                padding: const EdgeInsets.all(12),
                child: Card(
                    elevation: 1,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(_meeting.content ?? '',
                            style: Theme.of(context).textTheme.titleLarge))))
          ])),

      /// 여행할 국가
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:
              IconLabelWidget(iconData: Icons.flag, label: _meeting.country!)),

      /// 여행기간
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IconLabelWidget(
              iconData: Icons.calendar_today,
              label:
                  '${_meeting.dateRangeRepr}(${_meeting.durationInDay}days)')),

      /// 성별
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IconLabelWidget(
              iconData: Icons.male, label: '${_meeting.sex?.label}')),

      /// 여행 테마
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IconLabelWidget(
              iconData: Icons.travel_explore,
              label: '${_meeting.theme?.label}')),

      /// 예산
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: IconLabelWidget(
              iconData: Icons.money,
              label: '${_meeting.minCost}~${_meeting.maxCost}만원'))
    ])));
  }
}
