part of 'page.dart';

class SelectCountryFragment extends StatefulWidget {
  const SelectCountryFragment({super.key});

  @override
  State<SelectCountryFragment> createState() => _SelectCountryFragmentState();
}

class _SelectCountryFragmentState extends State<SelectCountryFragment> {
  late TextEditingController _countryTec;

  @override
  void initState() {
    super.initState();
    _countryTec = TextEditingController()..text = 'where do you want to go?';
  }

  @override
  void dispose() {
    super.dispose();
    _countryTec.dispose();
  }

  _handleOnSelect(Country country) {
    context.read<CreateMeetingCubit>().updateState(context
        .read<CreateMeetingCubit>()
        .state
        .copyWith(country: country.name));
    setState(() {
      _countryTec.text =
          '${country.flagEmoji} ${(country.nameLocalized ?? country.name)}';
    });
  }

  _handleShowModal() async {
    showCountryPicker(
        context: context,
        useSafeArea: true,
        favorite: <String>['KR', 'JP'],
        onSelect: _handleOnSelect,
        moveAlongWithKeyboard: false,
        countryListTheme: CountryListThemeData(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            inputDecoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Start typing to search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2)))),
            searchTextStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          const Icon(Icons.airplanemode_active),
          const SizedBox(width: 12),
          Text('Country',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold))
        ]),
        TextField(
            onTap: _handleShowModal,
            readOnly: true,
            controller: _countryTec,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.secondary),
            decoration: const InputDecoration(
                hintText: 'select country you want to travel'))
      ],
    );
  }
}
