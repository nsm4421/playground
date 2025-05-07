part of "recommend_itinerary.page.dart";

class RecommendItineraryScreen extends StatefulWidget {
  const RecommendItineraryScreen({super.key});

  @override
  State<RecommendItineraryScreen> createState() =>
      _RecommendItineraryScreenState();
}

class _RecommendItineraryScreenState extends State<RecommendItineraryScreen> {
  Country? _country;
  TendencyType _tendencyType = TendencyType.activity;
  AccompanyType _accompanyType = AccompanyType.solo;

  _handleSelectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          _country = country;
        });
      },
    );
  }

  _handleUnSelectCountry() {
    setState(() {
      _country = null;
    });
  }

  _handleSelectAccompany(AccompanyType type) => () {
        setState(() {
          _accompanyType = type;
        });
      };

  _handleSelectTendency(TendencyType type) => () {
        setState(() {
          _tendencyType = type;
        });
      };

  _handleSubmit() async {
    if (_country == null) {
      Fluttertoast.showToast(msg: 'select country first');
      return;
    } else {
      await context.read<RecommendItineraryCubit>().search(
          country: _country!.name,
          tendencyType: _tendencyType,
          accompanyType: _accompanyType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recommend")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 방문 국가
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.flag_outlined,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 12),
                            Text('Which Country?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: _country == null
                              ? ElevatedButton(
                                  onPressed: _handleSelectCountry,
                                  child: const Text('Select Country'))
                              : Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer
                                                .withOpacity(0.8)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                '${_country!.flagEmoji}   ${_country!.name}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSecondary,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            const SizedBox(width: 30),
                                            IconButton(
                                                onPressed:
                                                    _handleUnSelectCountry,
                                                icon: Icon(
                                                  Icons.clear,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .outline,
                                                ))
                                          ],
                                        )),
                                  ],
                                ))
                    ])),

            /// 목적
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.airplanemode_active_outlined,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 12),
                            Text('Purpose',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold))
                          ])),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Wrap(
                          children: TendencyType.values
                              .map((type) => Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: ElevatedButton(
                                        onPressed: _handleSelectTendency(type),
                                        style: type == _tendencyType
                                            ? ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                foregroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 12),
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              )
                                            : null,
                                        child: Text(
                                          type.label,
                                        )),
                                  ))
                              .toList())),
                ],
              ),
            ),

            /// 동행
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person,
                                color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 12),
                            Text('Accompany',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold))
                          ])),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Wrap(
                          children: AccompanyType.values
                              .map((type) => Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: ElevatedButton(
                                        onPressed: _handleSelectAccompany(type),
                                        style: type == _accompanyType
                                            ? ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                foregroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 12),
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge
                                                    ?.copyWith(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              )
                                            : null,
                                        child: Text(
                                          type.label,
                                        )),
                                  ))
                              .toList())),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
        onPressed: _handleSubmit,
        child: const Icon(Icons.search),
      ),
    );
  }
}
