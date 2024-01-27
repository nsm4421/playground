import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/feed.enum.dart';
import 'bloc/search.bloc.dart';
import 'bloc/search.event.dart';

class SearchHeaderWidget extends StatefulWidget {
  const SearchHeaderWidget({super.key});

  @override
  State<SearchHeaderWidget> createState() => _SearchHeaderWidgetState();
}

class _SearchHeaderWidgetState extends State<SearchHeaderWidget> {
  late SearchOption _option;

  @override
  initState() {
    super.initState();
    _option = SearchOption.values[0];
  }

  _handleOption(SearchOption option) => () => setState(() {
        _option = option;
      });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: SearchOption.values
                  .map((o) => InkWell(
                        onTap: _handleOption(o),
                        child: _OptionItem(option: o, selected: o == _option),
                      ))
                  .toList()),
          _TextField(_option)
        ],
      );
}

class _OptionItem extends StatelessWidget {
  const _OptionItem({super.key, required this.option, required this.selected});

  final SearchOption option;
  final bool selected;

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary),
      width: MediaQuery.of(context).size.width / SearchOption.values.length,
      height: 40,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        selected
            ? Icon(option.activeIcon,
                color: Theme.of(context).colorScheme.onPrimary, size: 28)
            : Icon(option.icon,
                color: Theme.of(context).colorScheme.onTertiary, size: 23),
        const SizedBox(width: 5),
        Text(option.label,
            style: selected
                ? Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary)
                : Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onTertiary))
      ]));
}

class _TextField extends StatefulWidget {
  const _TextField(this.option);

  final SearchOption option;

  @override
  State<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  late TextEditingController _tec;

  static const int _maxLen = 25;

  @override
  initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handleSearch() {
    final keyword = _tec.text.trim();
    if (keyword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('enter keyword'),
        duration: Duration(seconds: 3),
      ));
      return;
    }
    if (keyword.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('at least press 3 char'),
        duration: Duration(seconds: 3),
      ));
      return;
    }
    switch (widget.option) {
      case SearchOption.hashtag:
      case SearchOption.content:
        context
            .read<SearchBloc>()
            .add(SearchFeedEvent(keyword: keyword, option: widget.option));
      case SearchOption.nickname:
        context.read<SearchBloc>().add(SearchUserEvent(keyword: keyword));
    }
    setState(() {});
  }

  _handleClearSearch() => _tec.clear();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _tec,
              style: GoogleFonts.karla(
                  color: Theme.of(context).colorScheme.primary,
                  decorationThickness: 0,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              maxLength: _maxLen,
              decoration: InputDecoration(
                  prefixIcon:
                      Icon(context.read<SearchBloc>().state.option.icon),
                  hintText: "keyword (max $_maxLen char)",
                  border: InputBorder.none,
                  counterText: '',
                  suffixIcon: IconButton(
                      icon: Icon(Icons.clear,
                          size: 25,
                          color: Theme.of(context).colorScheme.secondary),
                      onPressed: _handleClearSearch)),
            ),
          ),
          InkWell(
            onTap: _handleSearch,
            child: Container(
                padding: const EdgeInsets.all(5),
                child: Icon(Icons.search,
                    size: 28, color: Theme.of(context).colorScheme.primary)),
          ),
          const SizedBox(width: 10)
        ],
      );
}
