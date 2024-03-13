import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/presentation/map/bloc/search/search_place.event.dart';
import 'package:hot_place/presentation/map/bloc/search/search_place.state.dart';
import 'package:hot_place/presentation/map/widget/search_option.widget.dart';
import 'package:hot_place/presentation/map/widget/searched_item.widget.dart';

import '../../core/constant/status.costant.dart';
import '../../core/util/toast.util.dart';
import 'bloc/search/search_place.bloc.dart';

class SearchPlaceScreen extends StatefulWidget {
  const SearchPlaceScreen({super.key});

  @override
  State<SearchPlaceScreen> createState() => _SearchPlaceScreenState();
}

class _SearchPlaceScreenState extends State<SearchPlaceScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<SearchPlaceBloc>()..add(InitSearch()),
        child: BlocBuilder<SearchPlaceBloc, SearchPlaceState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
              case Status.success:
                return const _SearchView();
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return const Center(child: Text("ERROR"));
            }
          },
        ),
      );
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  _showCategoryModalSheet() => showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext ctx) => SearchOptionWidget(
          initialState: context.read<SearchPlaceBloc>().state,
          handleSearch: ({CategoryGroupCode? category, String? keyword}) {
            if (category == null && keyword == null) {
              ToastUtil.toast('카테고리나 키워드를 입력해주세요');
              return;
            } else if (keyword != null) {
              context.read<SearchPlaceBloc>().add(SearchByCategoryAndKeyword(
                  keyword: keyword, category: category));
            } else {
              context
                  .read<SearchPlaceBloc>()
                  .add(SearchByCategory(category: category!));
            }
          }));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("검색하기"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            // 검색 옵션
            (context.read<SearchPlaceBloc>().state.category == null) &&
                    (context.read<SearchPlaceBloc>().state.keyword == null)

                // 검색 옵션이 설정되지 않은 경우
                ? ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondaryContainer)),
                    onPressed: _showCategoryModalSheet,
                    child: Center(
                        child: Text("검색옵션 선택하기",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary))))
                // 검색 옵션이 설정된 경우
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("옵션",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700)),
                            const Spacer(),
                            IconButton(
                                onPressed: _showCategoryModalSheet,
                                icon: Icon(Icons.settings,
                                    color:
                                        Theme.of(context).colorScheme.primary))
                          ],
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          children: [
                            if (context
                                    .read<SearchPlaceBloc>()
                                    .state
                                    .category !=
                                null)
                              Container(
                                constraints: const BoxConstraints.tightFor(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.category),
                                    const SizedBox(width: 8),
                                    Text(context
                                        .read<SearchPlaceBloc>()
                                        .state
                                        .category!
                                        .description)
                                  ],
                                ),
                              ),
                            if (context.read<SearchPlaceBloc>().state.keyword !=
                                null)
                              Container(
                                margin: const EdgeInsets.only(left: 15),
                                constraints: const BoxConstraints.tightFor(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.keyboard),
                                    const SizedBox(width: 8),
                                    Text(context
                                        .read<SearchPlaceBloc>()
                                        .state
                                        .keyword!)
                                  ],
                                ),
                              ),
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              constraints: const BoxConstraints.tightFor(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.navigation),
                                  const SizedBox(width: 8),
                                  Text(
                                      "${context.read<SearchPlaceBloc>().state.radius}m")
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            // 조회된 장소 목록
            context.read<SearchPlaceBloc>().state.places.isEmpty
                ? Expanded(
                    child: Center(
                        child: Text("No DATA",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary))))
                : Expanded(
                    child: SearchedItem(
                        context.read<SearchPlaceBloc>().state.places))
          ],
        ),
      );
}
