part of 'page.dart';

class SelectDateFragment extends StatefulWidget {
  const SelectDateFragment({super.key});

  @override
  State<SelectDateFragment> createState() => _SelectDateFragmentState();
}

class _SelectDateFragmentState extends State<SelectDateFragment> {
  final DateTime _today = DateTime.now();
  final _firstDate = DateTime.now();
  final _lastDate = DateTime(2100);

  _handleSelectDate() async {
    await showDateRangePicker(
            context: context,
            firstDate: _firstDate,
            lastDate: DateTime(2100),
            initialDateRange: DateTimeRange(
                start: context.read<CreateMeetingCubit>().state.startDate,
                end: context.read<CreateMeetingCubit>().state.endDate))
        .then((res) {
      if (res != null) {
        context.read<CreateMeetingCubit>().updateState(
            isDateSelected: true, startDate: res.start, endDate: res.end);
      }
    });
  }

  String _formatDt(DateTime dt) => '${dt.year}-${dt.month}-${dt.day}';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMeetingCubit, CreateMeetingState>(
        builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const IconLabelWidget(iconData: Icons.calendar_today, label: 'Date'),
        GestureDetector(
          onTap: _handleSelectDate,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Text(
                state.isDateSelected
                    ? '${_formatDt(state.startDate)} ~ ${_formatDt(state.endDate)}'
                        ' (${state.endDate.difference(state.startDate).inDays} days)'
                    : 'need to select date',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary)),
          ),
        ),
        if (state.isDateSelected)
          TableCalendar(
              focusedDay: _today,
              headerVisible: false,
              firstDay: _firstDate,
              lastDay: _lastDate,
              calendarFormat: CalendarFormat.month,
              rangeStartDay: state.startDate,
              rangeEndDay: state.endDate,
              calendarStyle: CalendarStyle(
                  rangeStartDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle),
                  rangeEndDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle)))
      ]);
    });
  }
}
