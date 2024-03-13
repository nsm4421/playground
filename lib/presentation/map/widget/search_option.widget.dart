import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/map/bloc/search/search_place.state.dart';

import '../../../core/constant/map.constant.dart';

class SearchOptionWidget extends StatefulWidget {
  const SearchOptionWidget(
      {super.key, required this.initialState, required this.handleSearch});

  final SearchPlaceState initialState;
  final void Function({CategoryGroupCode? category, String? keyword})
      handleSearch;

  @override
  State<SearchOptionWidget> createState() => _SearchOptionWidgetState();
}

class _SearchOptionWidgetState extends State<SearchOptionWidget> {
  static const int _minRadius = 200;
  static const int _maxRadius = 1000;

  late TextEditingController _tec;
  late CategoryGroupCode? _category;
  late int _radius;
  bool _useKeyword = false;

  @override
  initState() {
    super.initState();
    _tec = TextEditingController();
    _category = widget.initialState.category;
    _radius = widget.initialState.radius;
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handlePop() => context.pop();

  _handleClear() => _tec.clear();

  _handleUseKeyword() => setState(() {
        _useKeyword = !_useKeyword;
      });

  _handleRadius(int delta) => () => setState(() {
        _radius += delta;
        _radius = min(_radius, _maxRadius);
        _radius = max(_radius, _minRadius);
      });

  _handleCategory(CategoryGroupCode category) => () => setState(() {
        _category = (_category == category) ? null : category;
      });

  _handleSearch() {
    final keyword =
        _tec.text.trim().isNotEmpty && _useKeyword ? _tec.text.trim() : null;
    widget.handleSearch(category: _category, keyword: keyword);
    if (context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 헤더
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("검색 옵션",
                        style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    IconButton(
                        onPressed: _handlePop, icon: const Icon(Icons.logout)),
                  ],
                ),
                Text("검색어 입력하거나 카테고리를 선택해주세요",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                    softWrap: true)
              ],
            ),
          ),

          // 키워드 검색
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Row(children: [
              const Icon(Icons.keyboard),
              const SizedBox(width: 5),
              Text("Keyword", style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              IconButton(
                  onPressed: _handleUseKeyword,
                  icon: _useKeyword
                      ? Icon(Icons.keyboard_arrow_up,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.6))
                      : Icon(Icons.keyboard_arrow_down,
                          color: Theme.of(context).colorScheme.primary))
            ]),
          ),
          if (_useKeyword)
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: TextFormField(
                controller: _tec,
                style: const TextStyle(decorationThickness: 0),
                decoration: InputDecoration(
                    hintText: "상도동 카페",
                    suffixIcon: IconButton(
                        onPressed: _handleClear,
                        icon: Icon(Icons.clear,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.6)))),
                minLines: 1,
                maxLines: 1,
                maxLength: 20,
              ),
            ),

          // 카테고리
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Row(children: [
              const Icon(Icons.category_outlined),
              const SizedBox(width: 5),
              Text("Category", style: Theme.of(context).textTheme.titleMedium),
            ]),
          ),

          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Wrap(
                  children: CategoryGroupCode.values
                      .map((category) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(_category == category
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer)),
                              onPressed: _handleCategory(category),
                              child: Text(category.description,
                                  style: _category == category
                                      ? Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold)
                                      : Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: Theme.of(context).colorScheme.tertiary)))))
                      .toList())),

          // 거리
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Row(children: [
              const Icon(Icons.navigation),
              const SizedBox(width: 5),
              Text("Distance", style: Theme.of(context).textTheme.titleMedium),
            ]),
          ),

          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer),
                      child: Text("${_radius}m")),
                  const Spacer(),
                  if (_radius != _minRadius)
                    IconButton(
                        onPressed: _handleRadius(-100),
                        icon: const Icon(Icons.exposure_minus_1)),
                  if (_radius != _maxRadius)
                    IconButton(
                        onPressed: _handleRadius(100),
                        icon: const Icon(Icons.plus_one))
                ],
              ))
        ])),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _handleSearch, label: const Icon(Icons.search)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ));
}
