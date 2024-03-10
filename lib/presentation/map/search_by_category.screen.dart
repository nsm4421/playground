import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/presentation/map/bloc/category/category.bloc.dart';
import 'package:hot_place/presentation/map/bloc/category/category.event.dart';
import 'package:hot_place/presentation/map/widget/category_item.widget.dart';
import 'package:hot_place/presentation/map/widget/searched_item.widget.dart';

import '../../core/constant/map.constant.dart';
import '../../core/constant/status.costant.dart';
import 'bloc/category/category.state.dart';

class SearchByCategoryScreen extends StatefulWidget {
  const SearchByCategoryScreen({super.key});

  @override
  State<SearchByCategoryScreen> createState() => _SearchByCategoryScreenState();
}

class _SearchByCategoryScreenState extends State<SearchByCategoryScreen> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<CategoryBloc>()..add(InitCategory()),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
              case Status.success:
                return const _CategoryView();
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return const Center(child: Text("ERROR"));
            }
          },
        ),
      );
}

class _CategoryView extends StatefulWidget {
  const _CategoryView({super.key});

  @override
  State<_CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<_CategoryView> {
  _handleSelect(CategoryGroupCode category) => setState(() {
        context.read<CategoryBloc>().add(CategoryChanged(category));
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("카테고리로 검색하기"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: CategoryItems(
                currentCategory: context.read<CategoryBloc>().state.category,
                handleSelect: _handleSelect,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            SearchedItem(context.read<CategoryBloc>().state.places)
          ],
        ),
      );
}
