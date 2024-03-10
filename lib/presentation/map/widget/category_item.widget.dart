import 'package:flutter/material.dart';

import '../../../core/constant/map.constant.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems(
      {super.key, required this.currentCategory, required this.handleSelect});

  final CategoryGroupCode? currentCategory;
  final void Function(CategoryGroupCode category) handleSelect;

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  _handleSelect(CategoryGroupCode category) => () => setState(() {
        widget.handleSelect(category);
      });

  @override
  Widget build(BuildContext context) => Wrap(
        children: CategoryGroupCode.values
            .map((cat) => ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        widget.currentCategory == cat
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.tertiaryContainer)),
                onPressed: _handleSelect(cat),
                child: Text(cat.description,
                    style: widget.currentCategory == cat
                        ? Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold)
                        : Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary))))
            .toList(),
      );
}
