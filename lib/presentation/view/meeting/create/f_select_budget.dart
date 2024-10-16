part of 'page.dart';

class SelectBudgetFragment extends StatefulWidget {
  const SelectBudgetFragment({super.key});

  @override
  State<SelectBudgetFragment> createState() => _SelectBudgetFragmentState();
}

class _SelectBudgetFragmentState extends State<SelectBudgetFragment> {
  static const _firstCost = 10;
  static const _lastCost = 500;

  _handleChangeSlider(RangeValues values) {
    context.read<CreateMeetingCubit>().updateState(
        minCost: values.start.toInt(), maxCost: values.end.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
        builder: (context, state) {
      return Column(children: [
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Icon(Icons.wallet),
          const SizedBox(width: 12),
          Text('Budget Range',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text('${state.minCost}~${state.maxCost}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold))
        ]),
        RangeSlider(
          values:
              RangeValues(state.minCost.toDouble(), state.maxCost.toDouble()),
          min: _firstCost.toDouble(),
          max: _lastCost.toDouble(),
          divisions: (_lastCost - _firstCost) ~/ 10,
          labels: RangeLabels(
            state.minCost.toString(),
            state.maxCost.toString(),
          ),
          onChanged: _handleChangeSlider,
        ),
        const SizedBox(height: 12)
      ]);
    });
  }
}
