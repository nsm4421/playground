part of 'page.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({super.key});

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  static const int _maxLength = 20;
  late TextEditingController _tec;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Row(children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'search title',
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search,
                            color: Theme.of(context).colorScheme.primary)),
                    border: const OutlineInputBorder()))),
        IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt))
      ])
    ]);
  }
}
