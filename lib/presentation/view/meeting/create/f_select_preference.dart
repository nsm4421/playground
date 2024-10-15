part of 'page.dart';

class SelectPreferenceFragment extends StatefulWidget {
  const SelectPreferenceFragment({super.key});

  @override
  State<SelectPreferenceFragment> createState() =>
      _SelectPreferenceFragmentState();
}

class _SelectPreferenceFragmentState extends State<SelectPreferenceFragment> {
  static const int _minHeadCount = 2;
  static const int _maxHeadCount = 10;

  _handleSex(TravelPeopleSexType sex) => () {
        context.read<CreateMeetingCubit>().setSex(sex);
      };

  _handleTheme(TravelThemeType theme) => () {
        context.read<CreateMeetingCubit>().setTheme(theme);
      };

  _handleHeadCount(double value) {
    context.read<CreateMeetingCubit>().setHeadCount(value.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // 성별
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Icon(Icons.male),
            const SizedBox(width: 12),
            Text('Sex',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold))
          ]),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Wrap(
                  children: TravelPeopleSexType.values.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                      onPressed: _handleSex(item),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: state.sex == item
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : null,
                          elevation: state.sex == item ? 3 : 0),
                      child: Text(item.label,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: state.sex == item
                                      ? FontWeight.bold
                                      : FontWeight.w300))),
                );
              }).toList()))
        ]),

        // 여행 테마
        Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Icon(Icons.travel_explore),
            const SizedBox(width: 12),
            Text('Theme',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold))
          ]),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Wrap(
                  children: TravelThemeType.values.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                      onPressed: _handleTheme(item),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: state.theme == item
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : null,
                          elevation: state.theme == item ? 3 : 0),
                      child: Text(item.label,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: state.theme == item
                                      ? FontWeight.bold
                                      : FontWeight.w300))),
                );
              }).toList()))
        ]),

        // 동반 인원수
        Column(children: [
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Icon(Icons.info_outline),
            const SizedBox(width: 12),
            Text('Head Count',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            Text(state.headCount.toStringAsFixed(0),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary))
          ]),
          Slider(
            value: state.headCount.toDouble(),
            min: _minHeadCount.toDouble(),
            max: _maxHeadCount.toDouble(),
            divisions: _maxHeadCount - _minHeadCount,
            label: state.headCount.toString(),
            onChanged: _handleHeadCount,
          ),
          const SizedBox(height: 12)
        ])
      ]);
    });
  }
}
