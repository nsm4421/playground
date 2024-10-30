part of 'page.dart';

class OptionModalModal extends StatefulWidget {
  const OptionModalModal(this._initialOption, {super.key});

  final MeetingSearchOption _initialOption;

  @override
  State<OptionModalModal> createState() => _OptionModalModalState();
}

class _OptionModalModalState extends State<OptionModalModal> {
  static const int _maxLength = 20;
  late TextEditingController _tec;
  late MeetingSearchOption _option;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _option = widget._initialOption;
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handleClear() {
    _tec.clear();
    _handleOption(hashtag: '');
  }

  _handleOption(
          {String? hashtag, AccompanySexType? sex, TravelThemeType? theme}) =>
      () {
        setState(() {
          _option = _option.copyWith(hashtag: hashtag, sex: sex, theme: theme);
        });
      };

  _handleSubmit() {
    context.pop<MeetingSearchOption>(_option);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8,
          right: 12,
          left: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('검색옵션',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Text('Hashtag',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                  controller: _tec,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.tag),
                      suffixIcon: IconButton(
                          onPressed: _handleClear, icon: Icon(Icons.clear)),
                      hintText: '해외여행',
                      helperText: '$_maxLength내로 입력해주세요')),
              const SizedBox(height: 16),
              Text('Preference',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Wrap(
                  children: AccompanySexType.values.map((item) {
                final selected = item == _option.sex;
                return GestureDetector(
                    onTap: _handleOption(sex: item),
                    child: Container(
                        margin: const EdgeInsets.only(right: 12, top: 8),
                        decoration: BoxDecoration(
                            color: selected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Text(item.label,
                            style: selected
                                ? Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.bold)
                                : Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary,
                                        fontWeight: FontWeight.w400))));
              }).toList()),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider()),
              Wrap(
                  children: TravelThemeType.values.map((item) {
                final selected = item == _option.theme;
                return GestureDetector(
                    onTap: _handleOption(theme: item),
                    child: Container(
                        margin: const EdgeInsets.only(right: 12, top: 8),
                        decoration: BoxDecoration(
                            color: selected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Text(item.label,
                            style: selected
                                ? Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.bold)
                                : Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary,
                                        fontWeight: FontWeight.w400))));
              }).toList()),
            ]),
          ),
          floatingActionButton: FloatingActionButton.small(
              onPressed: _handleSubmit, child: const Icon(Icons.search))),
    );
  }
}
