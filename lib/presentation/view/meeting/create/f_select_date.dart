part of 'page.dart';

class SelectDateFragment extends StatefulWidget {
  const SelectDateFragment({super.key});

  @override
  State<SelectDateFragment> createState() => _SelectDateFragmentState();
}

class _SelectDateFragmentState extends State<SelectDateFragment> {
  _handleSelectDate() async {
    await showDateRangePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100))
        .then((res) {
      if (res != null) {
        setState(() {
          context.read<CreateMeetingCubit>().updateState(context
              .read<CreateMeetingCubit>()
              .state
              .copyWith(startDate: res.start, endDate: res.end));
        });
      }
    });
  }

  String _formatDt(DateTime dt) => '${dt.year}-${dt.month}-${dt.day}';

  @override
  Widget build(BuildContext context) {
    final startDate = context.read<CreateMeetingCubit>().state.startDate;
    final endDate = context.read<CreateMeetingCubit>().state.endDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Icon(Icons.calendar_today),
          const SizedBox(width: 12),
          Text('Date',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold))
        ]),
        const SizedBox(height: 12),
        InkWell(
            onTap: _handleSelectDate,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (startDate == null) || (endDate == null)
                    // 아직 날짜를 선택하지 않은 경우
                    ? Text('Select Date',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600))
                    // 날짜를 선택한 경우
                    : Text(
                        '${_formatDt(startDate)}  ~ ${_formatDt(endDate)} (${endDate.difference(startDate).inDays}days)',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600))
              ],
            )),
      ],
    );
  }
}
