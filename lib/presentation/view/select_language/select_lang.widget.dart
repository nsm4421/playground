part of '../index.page.dart';

class SelectLangWidget extends StatefulWidget {
  const SelectLangWidget(
      {super.key,
      required this.label,
      this.initialLang,
      required this.setLang});

  final String label;
  final Lang? initialLang;
  final void Function(Lang? lang) setLang;

  @override
  State<SelectLangWidget> createState() => _SelectLangWidgetState();
}

class _SelectLangWidgetState extends State<SelectLangWidget> {
  late TextEditingController _tec;
  late List<Lang> _options;
  late Lang? _lang;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _options = Lang.values;
    _lang = widget.initialLang;
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
    _debounce?.cancel();
  }

  void _onSourceChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _options = Lang.values
            .where((item) =>
                item.lang.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  void Function() _handleSelect(Lang lang) => () {
        setState(() {
          _lang = lang;
          widget.setLang(lang);
          _tec.text = lang.lang.name;
        });
      };

  void _handleClear() {
    setState(() {
      _lang = null;
      _tec.clear();
      _options = Lang.values;
      widget.setLang(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          readOnly: _lang != null,
          controller: _tec,
          onChanged: _onSourceChanged,
          style: _lang == null
              ? Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(decorationThickness: 0)
              : Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  decorationThickness: 0),
          decoration: InputDecoration(
              labelText: widget.label,
              suffixIcon: (_lang != null || _tec.text.isNotEmpty)
                  ? IconButton(
                      onPressed: _handleClear,
                      icon: const Icon(Icons.clear),
                    )
                  : null),
        ),

        if (_lang == null)
        ListView.builder(
            shrinkWrap: true,
            itemCount: _options.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: _handleSelect(_options[index]),
                title: Text(
                  _options[index].lang.name,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(decorationThickness: 0),
                ),
              );
            })
      ],
    );
  }
}
