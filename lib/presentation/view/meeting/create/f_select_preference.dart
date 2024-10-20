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
  static const _firstCost = 10;
  static const _lastCost = 500;

  _handleSex(AccompanySexType sex) => () {
        context.read<CreateMeetingCubit>().updateState(sex: sex);
      };

  _handleTheme(TravelThemeType theme) => () {
        context.read<CreateMeetingCubit>().updateState(theme: theme);
      };

  _handleHeadCount(double headCount) {
    context
        .read<CreateMeetingCubit>()
        .updateState(headCount: headCount.toInt());
  }

  _handleChangeSlider(RangeValues values) {
    context.read<CreateMeetingCubit>().updateState(
        minCost: values.start.toInt(), maxCost: values.end.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const IconLabelWidget(
            iconData: Icons.people_alt_outlined, label: 'Preference'),

        /// 성별
        Card(
            elevation: 1,
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Wrap(
                    children: AccompanySexType.values.map((item) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                          onPressed: _handleSex(item),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: state.sex == item
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                  : null,
                              elevation: state.sex == item ? 3 : 0),
                          child: Text(item.label,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: state.sex == item
                                          ? FontWeight.bold
                                          : FontWeight.w300))));
                }).toList()))),

        /// 여행 테마
        Card(
            elevation: 1,
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Wrap(
                    children: TravelThemeType.values.map((item) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ElevatedButton(
                          onPressed: _handleTheme(item),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: state.theme == item
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                  : null,
                              elevation: state.theme == item ? 3 : 0),
                          child: Text(item.label,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: state.theme == item
                                          ? FontWeight.bold
                                          : FontWeight.w300))));
                }).toList()))),

        /// 최대 동반 인원수
        Card(
            elevation: 1,
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Maximum Head Count',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                          const Spacer(),
                          Text('${state.headCount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Slider(
                          value: state.headCount.toDouble(),
                          min: _minHeadCount.toDouble(),
                          max: _maxHeadCount.toDouble(),
                          divisions: _maxHeadCount - _minHeadCount,
                          label: state.headCount.toString(),
                          onChanged: _handleHeadCount)
                    ]))),

        /// 예산 범위
        Card(
            elevation: 1,
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Budget Range',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                          const Spacer(),
                          Text('${state.minCost}~${state.maxCost}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary))
                        ],
                      ),
                      const SizedBox(height: 8),
                      RangeSlider(
                          values: RangeValues(state.minCost.toDouble(),
                              state.maxCost.toDouble()),
                          min: _firstCost.toDouble(),
                          max: _lastCost.toDouble(),
                          divisions: (_lastCost - _firstCost) ~/ 10,
                          labels: RangeLabels(
                            state.minCost.toString(),
                            state.maxCost.toString(),
                          ),
                          onChanged: _handleChangeSlider)
                    ]))),
      ]);
    });
  }
}
