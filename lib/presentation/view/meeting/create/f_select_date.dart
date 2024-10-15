part of 'page.dart';

class SelectDateFragment extends StatefulWidget {
  const SelectDateFragment({super.key});

  @override
  State<SelectDateFragment> createState() => _SelectDateFragmentState();
}

class _SelectDateFragmentState extends State<SelectDateFragment> {
  late DateTimeRange _dateTimeRange;
  bool _isSelected = false;
  final DateTime _today = DateTime.now();
  final _firstDate = DateTime(2000);
  final _lastDate = DateTime(2100);

  @override
  void initState() {
    super.initState();
    _dateTimeRange = context.read<CreateMeetingCubit>().state.dateRange ??
        DateTimeRange(start: _today, end: _today);
  }

  _handleSelectDate() async {
    await showDateRangePicker(
            context: context,
            firstDate: _firstDate,
            lastDate: DateTime(2100),
            initialDateRange: _dateTimeRange)
        .then((res) {
      if (res != null) {
        context.read<CreateMeetingCubit>().setDateRange(res);
        setState(() {
          _isSelected = true;
          _dateTimeRange = res;
        });
      }
    });
  }

  String _formatDt(DateTime dt) => '${dt.year}-${dt.month}-${dt.day}';

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.calendar_today),
        const SizedBox(width: 12),
        Text('Date',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold))
      ]),
      GestureDetector(
        onTap: _handleSelectDate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Text(
              _isSelected
                  ? '${_formatDt(_dateTimeRange.start)} ~ ${_formatDt(_dateTimeRange.end)}'
                      ' (${_dateTimeRange.end.difference(_dateTimeRange.start).inDays} days)'
                  : 'need to select date',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary)),
        ),
      ),
      TableCalendar(
          focusedDay: _today,
          headerVisible: false,
          firstDay: _firstDate,
          lastDay: _lastDate,
          calendarFormat: CalendarFormat.month,
          rangeStartDay: _dateTimeRange.start,
          rangeEndDay: _dateTimeRange.end,
          calendarStyle: CalendarStyle(
              rangeStartDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle),
              rangeEndDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle)))
    ]);
  }
}
